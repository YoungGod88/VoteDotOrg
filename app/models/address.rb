class Address < ApplicationRecord
  validates :house_number, presence: true
  validates :street_name, presence: true
  validates :city, presence: true
  validates :state, presence: true, length: { is: 2}
  validates :zip_5, presence: true, length: { is: 5}

  def self.validateAddress(address)
    #initialize response
    validity = {
      :valid => false,
      :address => {}
    }

     # check if address is valid
    if !address.nil? && !address['street_address'].nil?
      lob = Lob::Client.new(api_key: Rails.configuration.lob_api_key)
      response = lob.us_verifications.verify(
        primary_line: address['street_address'],
        city: address['city'],
        state: address['state'],
        zip_code: address['zip_code']
      )
  
      if response['deliverability'] != "undeliverable" &&
        response['components']['city'].casecmp(address['city']) #THIS IS ONLY INCLUDED BECAUSE THE API AUTOCORRECTS AND IDEALLY WOULD POP UP A 'DID YOU MEAN?' DIALOG
        validity[:valid] = true
        validity[:address] = parseAddress(response['components'])
      end
    end

    validity
  end

  def self.parseAddress(address)
    #nil check
    if !address.nil? && 
      !address['street_name'].nil? &&
      !address['county'].nil? &&
      !address['street_name'].nil? &&
      !address['state'].nil?
      {
        :house_number => address['primary_number'],
        :street_name => address['street_name'].titleize,
        :street_type => getStreetType(address['street_suffix']),
        :county => address['county'].titleize,
        :street_predirection => address['street_predirection'],
        :street_postdirection => address['street_postdirection'],
        :unit_number => address['secondary_number'],
        :unit_type => address['secondary_designator'],
        :city => address['city'].titleize,
        :state => address['state'].upcase,
        :zip_5 => address['zip_code'],
        :zip_4 => address['zip_code_plus_4']
      }
    end
  end

  def self.getStreetType(suffix)#Not sure if the street type should be normalized
    streetAbbv = {
      'avenue' => ['avenue', 'ave'],
      'road' => ['road', 'rd']
    }

    streetAbbv.each do |key, value|
      if value.map(&:downcase).include?(suffix.downcase)
        suffix = key.titleize
      end
    end

    suffix
  end

  def to_s
    # TODO: override the to_s method so that it prints out the address components as follows
    # house_number street_predirection street_name street_type street_postdirection unit_type unit_number, city, state, zip_5
    @streetAddress = [
      house_number, 
      street_predirection, 
      street_name, 
      street_type, 
      street_postdirection,
      unit_type, 
      unit_number
    ].reject(&:blank?).join(' ').strip

    #return full address
    [@streetAddress, city, state].join(", ").strip + ' ' + zip_5
  end
end
