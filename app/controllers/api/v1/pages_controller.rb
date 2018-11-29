# require 'fedex'

class Api::V1::PagesController < ApplicationController
	def index
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
		
		packages << {
		  :weight => {:units => "LB", :value => 6},
		  :dimensions => {:length => 5, :width => 5, :height => 4, :units => "IN" }
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

		p rate

		render :json => { :name => "any name" }
	end
end