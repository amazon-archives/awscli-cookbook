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
include_recipe 'awscli::default'

# Specifying all download options
awscli_s3_file "/tmp/testfile" do
  bucket node['test_get']['bucket']
  key node['test_get']['key']
  checksum node['test_get']['checksum']
  aws_access_key_id node['test_get']['aws_access_key_id']
  aws_secret_access_key node['test_get']['aws_secret_access_key']
  region node['test_get']['region']
end

# Default download options
awscli_s3_file "/tmp/testfile2" do
  bucket node['test_get']['bucket']
  key node['test_get']['key']
  aws_access_key_id node['test_get']['aws_access_key_id']
  aws_secret_access_key node['test_get']['aws_secret_access_key']
end
