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

describe 'awscli::_linux' do
  cached(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
      node.set['awscli']['virtualenv'] = '/opt/fake/pip'
    end.converge(described_recipe)
  end

  it 'installs groff package' do
    expect(chef_run).to install_package('groff')
  end

  it 'includes the python::pip recipe' do
    expect(chef_run).to include_recipe('python::pip')
  end

  it 'installs awscli via pip' do
    expect(chef_run).to install_python_pip('awscli')
      .with_virtualenv('/opt/fake/pip')
  end
end
