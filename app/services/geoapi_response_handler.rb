class GeoapiResponseHandler
  EXPECTED_VALUES = %w[countryCode countryCode3 countryName countryEmoji].freeze
  REDUNDAND_VALUES = ['country_code3'].freeze

  def self.run(response)
    service = new(response)
    service.validate_response_status
    service.build_data_hash
    service.validate_response_body
    service.snakify_keys
    service.remove_redundand_values

    service
  end

  attr_reader :data, :response

  def initialize(response)
    @response = response
  end

  def validate_response_status
    raise StandardError, 'Geoapi response failure' unless response.code == 200
  end

  def build_data_hash
    @data = response.to_h
  end

  def validate_response_body
    raise StandardError, 'Expected values are missing' unless data.keys.eql?(EXPECTED_VALUES)
  end

  def snakify_keys
    data.transform_keys!(&:underscore)
  end

  def remove_redundand_values
    data.reject! { |k, _| REDUNDAND_VALUES.include?(k) }
  end
end
