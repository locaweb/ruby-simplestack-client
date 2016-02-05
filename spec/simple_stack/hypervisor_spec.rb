# -*- coding: UTF-8 -*-
require "spec_helper"

describe SimpleStack::Hypervisor do
  let(:url) {"http://simplestack.server"}
  let(:host) {"hypervisor_host"}
  subject {SimpleStack::Connection.new(:url => url).connect_to :mock, host: host}

  it "should keep the connection url" do
    expect(subject.url).to eq("#{url}/mock/#{host}")
  end

  it "should connect to a hypervisor" do
    expect(subject.headers).to have_key("x-simplestack-version")
    expect(subject.headers).to have_key("x-simplestack-token")
    expect(subject.headers).to have_key("x-simplestack-hypervisor-token")
    expect(subject.headers["Content-Type"]).to eq("application/json")
  end

  it "should have a base64 encoded username:password token for now" do
    subject.username = "admin"
    subject.password = "secret"
    expect(subject.token).to eq("YWRtaW46c2VjcmV0")
  end
end
