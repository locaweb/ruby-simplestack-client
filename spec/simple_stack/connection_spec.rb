# -*- coding: UTF-8 -*-
require "spec_helper"

describe SimpleStack::Connection do
  let(:url) {"http://simplestack.server"}
  subject {SimpleStack::Connection.new :url => url}
  
  it "should keep the connection url" do
    subject.url.should == url
  end
  
  it "should connect to a hypervisor" do
    host = "hypervisor_host"
    hypervisor = subject.connect_to :mock, host: host
    hypervisor.type.should == :mock
    hypervisor.host.should == host
    hypervisor.url.should == "#{url}/mock/#{host}"
  end
end