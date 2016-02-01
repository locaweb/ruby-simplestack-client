# -*- coding: UTF-8 -*-
require "spec_helper"

describe SimpleStack::Connection do
  let(:url) {"http://simplestack.server"}
  subject {SimpleStack::Connection.new :url => url}

  it "should keep the connection url" do
    expect(subject.url).to eq(url)
  end

  it "should connect to a hypervisor" do
    host = "hypervisor_host"
    hypervisor = subject.connect_to :mock, host: host
    expect(hypervisor.type).to eq(:mock)
    expect(hypervisor.host).to eq(host)
    expect(hypervisor.url).to eq("#{url}/mock/#{host}")
  end
end
