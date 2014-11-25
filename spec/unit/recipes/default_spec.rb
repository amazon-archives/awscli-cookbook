require_relative '../spec_helper'

describe 'awscli::default' do

  context 'windows' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012').converge(described_recipe)
    end

    it 'includes the windows recipe' do
      expect(chef_run).to include_recipe('awscli::_windows')
    end
  end

  context 'linux' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe)
    end

    it 'includes the linux recipe' do
      expect(chef_run).to include_recipe('awscli::_linux')
    end
  end
end
