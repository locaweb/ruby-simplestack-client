# -*- coding: UTF-8 -*-
require "spec_helper"

describe SimpleStack::Hypervisor do
  let(:url) {"http://simplestack.server"}
  let(:host) {"hypervisor_host"}
  subject {SimpleStack::Connection.new(:url => url).connect_to :mock, host: host}
  
  it "should keep the connection url" do
    subject.url.should == "#{url}/mock/#{host}"
  end
  
  it "should connect to a hypervisor" do
    subject.headers.should have_key("x-simplestack-version")
    subject.headers.should have_key("x-simplestack-token")
    subject.headers.should have_key("x-simplestack-hypervisor-token")
    subject.headers["Content-Type"].should == "application/json"
  end
end