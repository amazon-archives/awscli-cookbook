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
  let(:chef_run) do
    ChefSpec::SoloRunner.new(
      :platform => 'ubuntu',
      :version => '14.04'
    )
  end

  it 'includes the python::pip recipe' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('python::pip')
  end

  it 'installs awscli via pip' do
    chef_run.node.set['awscli']['virtualenv'] = '/opt/fake/pip'
    chef_run.converge(described_recipe)
    expect(chef_run).to install_python_pip('awscli')
      .with_virtualenv('/opt/fake/pip')
  end

  it 'installs specified version of awscli via pip' do
    chef_run.node.set['awscli']['version'] = '1.10.4'
    chef_run.converge(described_recipe)
    expect(chef_run).to install_python_pip('awscli')
      .with_version('1.10.4')
  end

  it 'dont set version if value is set to present' do
    chef_run.node.set['awscli']['version'] = 'present'
    chef_run.converge(described_recipe)
    expect(chef_run).to install_python_pip('awscli')
      .with_version(nil)
  end
end
