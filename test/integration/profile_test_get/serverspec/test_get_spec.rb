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
require_relative '../../../kitchen/data/spec_helper'
require 'json'

node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))

describe file('/tmp/testfile') do
  it { should be_file }
  its(:sha256sum) { should eq node['test_get']['checksum'] }
end
