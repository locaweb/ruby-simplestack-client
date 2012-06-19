require "json"
require "base64"
require "httparty"
require "simple_stack/version"
require "simple_stack/connection"
require "simple_stack/collection"
require "simple_stack/hypervisor"
require "simple_stack/entity"
require "simple_stack/guest"
require "simple_stack/snapshot"

module SimpleStack
  def self.client
    HTTParty
  end
end
