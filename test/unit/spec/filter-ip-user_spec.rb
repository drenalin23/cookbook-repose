# frozen_string_literal: true
require 'chefspec'
require_relative 'spec_helper'

describe 'repose::filter-ip-user' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new.converge('repose::default', described_recipe) }
  let(:template) { chef_run.template('/etc/repose/ip-user.cfg.xml') }

  it 'includes the recipe repose::install' do
    expect(chef_run).to include_recipe('repose::install')
  end
  it 'sends a restart notification to the service repose-valve' do
    expect(template).to notify('service[repose-valve]').to(:restart)
  end
  it 'creates a template at /etc/repose/ip-user.cfg.xml' do
    expect(chef_run).to create_template('/etc/repose/ip-user.cfg.xml')
  end
end
