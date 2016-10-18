require 'httparty'
module RenaultAddress
  def self.config
    @config ||= Config.new
  end

  class Config
    attr_accessor :test_mode
    def initialize
      @test_mode = if defined?(Rails)
                     !Rails.env.production?
                   else
                     false
                   end
    end
  end

  class Service
    include HTTParty

    def initialize test_mode=RenaultAddress.config.test_mode
      if test_mode
        self.class.base_uri 'http://renault.cu-dev.nl/webservices/getdataapi/api'
      else
        self.class.base_uri 'https://web.renault.nl/webservices/getdataapi/api'
      end
    end

    def lookup zipcode, street_number
      address = self.class.get '/postcodes', query: {postcode: zipcode, huisnr: street_number}
      {
        street: address['straatnaam_NEN'],
        city: address['woonplaatsnaam_NEN'],
        zipcode: address['postcode'],
        street_number: street_number
      }
    end
  end
end
