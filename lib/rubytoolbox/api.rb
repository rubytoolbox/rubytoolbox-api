# frozen_string_literal: true

require "rubytoolbox/api/version"
require "uri"
require "json"
require "net/http"
require "rubytoolbox/api/response_wrapper"
require "rubytoolbox/api/category"
require "rubytoolbox/api/category_group"
require "rubytoolbox/api/project"
require "rubytoolbox/api/health"
require "rubytoolbox/api/rubygem"
require "rubytoolbox/api/github_repo"

module Rubytoolbox
  class Api
    class RequestError < StandardError; end

    DEFAULT_URL = "https://www.ruby-toolbox.com/api/"

    attr_accessor :endpoint_url
    private :endpoint_url=

    def initialize(url: DEFAULT_URL)
      self.endpoint_url = url.clone.freeze
    end

    def compare(*names)
      url = URI(File.join(endpoint_url, "projects", "compare", names.join(",")))

      data = handle_response! Net::HTTP.get_response(url)

      data.fetch("projects").map do |project_data|
        Project.new project_data
      end
    end

    private

    def handle_response!(response)
      case response.code.to_i
      when 200
        JSON.parse(response.body)
      else
        raise RequestError, error_message_for_response(response)
      end
    end

    def error_message_for_response(response)
      data = JSON.parse(response.body)

      "Unexpected response status #{response.code}! #{data['message']}"
    rescue JSON::ParserError
      "Unexpected response status #{response.code}! #{response.body}"
    end
  end
end
