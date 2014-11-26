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
