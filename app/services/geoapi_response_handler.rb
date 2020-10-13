class GeoapiResponseHandler
  EXPECTED_VALUES = %w[countryCode countryCode3 countryName countryEmoji].freeze
  REDUNDAND_VALUES = ['country_code3'].freeze

  def self.run(response)
    service = new(response)
    service.validate_response_status
    service.validate_response_values
    service.snakify_keys
    service.remove_redundand_values

    service
  end

  attr_reader :data, :response

  def initialize(response)
    @response = response
  end

  def validate_response_status
    raise StandardError unless response.code == 200

    @data = response.to_h
  end

  def validate_response_values
    raise StandardError unless data.keys.eql?(EXPECTED_VALUES)
  end

  def snakify_keys
    data.transform_keys!(&:underscore)
  end

  def remove_redundand_values
    data.reject! { |k, _| REDUNDAND_VALUES.include?(k) }
  end
end
