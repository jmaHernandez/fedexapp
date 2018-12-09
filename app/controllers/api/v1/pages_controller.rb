class Api::V1::PagesController < ApplicationController
	include Utils

	skip_before_action :verify_authenticity_token

	def test
		shipper = { :name => "Sender",
            :company => "Company",
            :phone_number => "555-555-5555",
            :address => "Main Street",
            :city => "Harrison",
            :state => "AR",
            :postal_code => "72601",
            :country_code => "US" }

		recipient = { :name => "Recipient",
              :company => "Company",
              :phone_number => "555-555-5555",
              :address => "Main Street",
              :city => "Franklin Park",
              :state => "IL",
              :postal_code => "60131",
              :country_code => "US",
              :residential => "false" }

		packages = []
		
		packages << {
		  :weight => {:units => "LB", :value => 4},
		  :dimensions => {:length => 10, :width => 5, :height => 4, :units => "IN" }
		}

		shipping_options = {
		  :packaging_type => "YOUR_PACKAGING",
		  :drop_off_type => "REGULAR_PICKUP"
		}

		fedex = Fedex::Shipment.new(
			:key => 'VDcptYMyyET3QZGL',
			:password => '3sET3ECzhTLcVGltPcpR5sKpv',
			:account_number => '510087429',
			:meter => '118729277',
			:mode => 'test'
		)

		rate = fedex.rate(:shipper=>shipper,
                  :recipient => recipient,
                  :packages => packages,
                  :service_type => "FEDEX_GROUND",
                  :shipping_options => shipping_options)

		render :json => rate
	end

	def uploadPackagesV1
		file = params[:packages].read
		data = JSON.parse(file)

		shipper = {
			:name => "Sender",
            :company => "Company",
            :phone_number => "555-555-5555",
            :address => "Main Street",
            :city => "Harrison",
            :state => "AR",
            :postal_code => "72601",
			:country_code => "US"
		}

		recipient = {
			:name => "Recipient",
        	:company => "Company",
            :phone_number => "555-555-5555",
            :address => "Main Street",
            :city => "Franklin Park",
            :state => "IL",
            :postal_code => "60131",
            :country_code => "US",
			:residential => "false"
		}

		shipping_options = {
			:packaging_type => "YOUR_PACKAGING",
			:drop_off_type => "REGULAR_PICKUP"
		}

		package_list = []

		data.each do |package|
			peso_kilogramos = (package['weight']['value'] / 2.2046).ceil
			peso_volumetrico = (((package['dimensions']['width'] * package['dimensions']['height'] * package['dimensions']['length']) / 5000.0) / 0.39370).ceil

			peso_total = peso_kilogramos

			if peso_volumetrico > peso_total
				peso_total = peso_volumetrico
			end

			# p peso_kilogramos
			# p peso_volumetrico
			# p peso_total

			fedex = Fedex::Shipment.new(
				:key => 'VDcptYMyyET3QZGL',
				:password => '3sET3ECzhTLcVGltPcpR5sKpv',
				:account_number => '510087429',
				:meter => '118729277',
				:mode => 'test'
			)

			packages = []
		
			packages << {
				:weight => {
					:units => package['weight']['units'],
					:value => package['weight']['value']
				},
				:dimensions => {
					:length => package['dimensions']['length'],
					:width => package['dimensions']['width'],
					:height => package['dimensions']['height'],
					:units => package['dimensions']['units']
				}
			}

			rate = fedex.rate(
				:shipper => shipper,
				:recipient => recipient,
				:packages => packages,
				:service_type => "FEDEX_GROUND",
				:shipping_options => shipping_options
			)

			carga_total_lb = (rate[0].total_net_charge).to_f
			carga_total = carga_total_lb / 2.2046

			sobrepeso = (carga_total - peso_total).ceil

			@package = Package.new(
				shipper: shipper[:name],
				recipient: recipient[:name],
				total_weight: peso_total,
				total_charge: carga_total,
				overweight: sobrepeso
			)

			@package.save
		end
		
		render :json => Package.all
	end

	def uploadPackagesV2
		file = params[:packages].read
		data = JSON.parse(file)

		fedex = Fedex::Shipment.new(
			:key => 'VDcptYMyyET3QZGL',
			:password => '3sET3ECzhTLcVGltPcpR5sKpv',
			:account_number => '510087429',
			:meter => '118729277',
			:mode => 'test'
		)

		data.each do |package|
			tracking_number = package['tracking_number']

			# pp tracking_number

			peso_kilogramos = CalcularPesoKilogramos(
				package['weight']['value'],
				package['weight']['units']
			)
			
			peso_volumetrico = CalcularPesoVolumetrico(
				package['dimensions']['width'],
				package['dimensions']['height'],
				package['dimensions']['length'],
				package['dimensions']['units']
			)

			peso_total = peso_kilogramos

			if peso_volumetrico > peso_total
				peso_total = peso_volumetrico
			end

			# pp peso_kilogramos
			# pp peso_volumetrico
			# pp peso_total

			begin
				results = fedex.track(:tracking_number => tracking_number)
			rescue
				next
			end

			tracking_info = results.first

			# tracking_info

			fedex_peso_kilogramos = CalcularPesoKilogramos(
				tracking_info.details[:package_weight][:value].to_f,
				tracking_info.details[:package_weight][:units].to_s
			)
			
			fedex_peso_volumetrico = CalcularPesoVolumetrico(
				tracking_info.details[:package_dimensions][:width].to_f,
				tracking_info.details[:package_dimensions][:height].to_f,
				tracking_info.details[:package_dimensions][:length].to_f,
				tracking_info.details[:package_dimensions][:units].to_s
			)

			fedex_peso_total = fedex_peso_kilogramos

			if fedex_peso_volumetrico > fedex_peso_total
				fedex_peso_total = fedex_peso_volumetrico
			end

			# pp fedex_peso_kilogramos
			# pp fedex_peso_volumetrico
			# pp fedex_peso_total

			sobrepeso = CalcularSobrepeso(peso_total, fedex_peso_total)

			# pp sobrepeso

			@package = Package.new(
				numero_rastreo: tracking_number,
				peso_kilogramos: peso_kilogramos,
				peso_volumetrico: peso_volumetrico,
				peso_total: peso_total,
				fedex_peso_kilogramos: fedex_peso_kilogramos,
				fedex_peso_volumetrico: fedex_peso_volumetrico,
				fedex_peso_total: fedex_peso_total,
				sobrepeso: sobrepeso
			)

			@package.save
		end

		render :json => data
	end

	def getPackages
		@packages = Package.all

		render :json => @packages
	end
end