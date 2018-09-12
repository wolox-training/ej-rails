# frozen_string_literal: true

module Response
  module JSONParser
    def response_body
      ActiveSupport::JSON.decode(response.body) if response.present? && response.body.present?
    end
  end
end
