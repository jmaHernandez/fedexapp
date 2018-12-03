class Api::V1::PagesController < ApplicationController
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

	def uploadPackages
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

			sobrepeso = carga_total - peso_total

			package_list << {
				:shipper => shipper[:name],
				:recipient => recipient[:name],
				:peso_total => peso_total.to_i,
				:carga_total => carga_total.round(2),
				:sobrepeso => sobrepeso.round(2)
			}
		end
		  
		render :json => package_list
	end
end