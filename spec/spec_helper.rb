# frozen_string_literal: true

require 'dotenv/load'
require 'webmock/rspec'
require_relative '../lib/exchange_it'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/specs.txt'
  # config.define_derived_metadata(file_path: /exchange_it\/utils/) do |meta|
  #   meta[:fast] = true
  # end

  # config.filter_run_excluding :win_only unless RUBY_PLATFORM.match?(/jruby/i)

  WebMock.allow_net_connect!

  WebMock::API.prepend(Module.new do
    extend self
    # disable VCR when a WebMock stub is created
    # for clearer spec failure messaging
    def stub_request(*args)
      VCR.turn_off!
      super
    end
  end)

  config.before { VCR.turn_on! }
end
