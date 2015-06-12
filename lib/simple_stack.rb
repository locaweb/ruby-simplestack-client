require "json"
require "base64"
require "httparty"
require "simple_stack/version"
require "simple_stack/exception"
require "simple_stack/connection"
require "simple_stack/cacheable"
require "simple_stack/collection"
require "simple_stack/hypervisor"
require "simple_stack/entity"
require "simple_stack/host"
require "simple_stack/storage"
require "simple_stack/guest"
require "simple_stack/snapshot"
require "simple_stack/network_interface"
require "simple_stack/network"
require "simple_stack/disk"

module SimpleStack
  def self.client
    HTTParty
  end
end
