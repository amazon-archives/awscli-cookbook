#
# Cookbook Name:: awscli
# Attributes:: default
#
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
default['awscli']['version'] = '1.10.4'
default['awscli']['virtualenv'] = nil
default['awscli']['windows_url'] = 'https://s3.amazonaws.com/aws-cli/AWSCLI64.msi'
default['awscli']['binary'] = case node['platform_family']
                              when 'windows'
                                '"C:\Program Files\Amazon\AWSCLI\aws"'
                              else
                                'aws'
                              end
