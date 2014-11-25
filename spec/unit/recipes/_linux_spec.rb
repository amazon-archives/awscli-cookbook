require_relative '../spec_helper'

describe 'awscli::_linux' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['awscli']['virtualenv'] = '/opt/fake/pip'
    end.converge(described_recipe)
  end

  it 'includes the python::pip recipe' do
    expect(chef_run).to include_recipe('python::pip')
  end

  it 'installs awscli via pip' do
    expect(chef_run).to install_python_pip('awscli')
      .with_virtualenv('/opt/fake/pip')
  end
end
