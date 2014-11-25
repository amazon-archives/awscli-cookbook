require_relative '../spec_helper'

describe 'awscli::_windows' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'windows', version: '2012', log_level: :debug) do |node|
      node.set['awscli']['windows_url'] = 'http://s3.amazonaws.com/fake/download/awscli.exe'
    end.converge(described_recipe)
  end

  it 'includes the windows cookbook recipe' do
    expect(chef_run).to include_recipe('windows')
  end

  it 'installs awscli directly from a download link' do
    expect(chef_run).to install_windows_package('AWS Command Line Interface')
      .with_source('http://s3.amazonaws.com/fake/download/awscli.exe')
  end
end
