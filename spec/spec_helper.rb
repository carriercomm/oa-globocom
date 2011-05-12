require "#{File.dirname(__FILE__)}/../lib/oa-cadun"
require 'fakeweb'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before :suite do
    FakeWeb.allow_net_connect = false
  end
  
  config.before :each do
    FakeWeb.clean_registry
  end
  
  config.mock_with :rr
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

def stub_requests
  FakeWeb.register_uri :put, "http://isp-authenticator.dev.globoi.com:8280/ws/rest/autorizacao",
                       :body => File.join(File.dirname(__FILE__), "support", "fixtures", "autorizacao.xml")

  FakeWeb.register_uri :get, "http://isp-authenticator.dev.globoi.com:8280/cadunii/ws/resources/pessoa/21737810", 
                       :body => File.join(File.dirname(__FILE__), "support", "fixtures", "pessoa.xml")
end