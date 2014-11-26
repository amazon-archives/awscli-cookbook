# Copyright 2014 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://aws.amazon.com/apache2.0/
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.
#
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
