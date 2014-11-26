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
directory '/tmp/serverspec' do
  recursive true
end

file '/tmp/serverspec/node.json' do
  owner "root"
  mode "0400"
end

ruby_block "dump_node_attributes" do
  block do
    require 'json'

    attrs = Hash.new

    attrs.merge!(node.default_attrs) unless node.default_attrs.empty?
    attrs.merge!(node.normal_attrs) unless node.normal_attrs.empty?
    attrs.merge!(node.override_attrs) unless node.override_attrs.empty?

    attrs['run_list'] = node.run_list.expand(node.chef_environment).recipes

    File.open('/tmp/serverspec/node.json', 'w') { |file| file.write(JSON.pretty_generate(attrs)) }
  end
end
