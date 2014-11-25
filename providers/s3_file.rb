#
# Cookbook Name:: awscli
# provider:: s3_file
#
# Copyright (C) 2014 Amazon Web Services
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut

use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

def load_current_resource
  @current_resource = Chef::Resource::AwscliS3File.new(new_resource.name)
  @current_resource.bucket(new_resource.bucket)
  @current_resource.key(new_resource.key)
  @current_resource.path(new_resource.path)
  @current_resource.region(new_resource.region)
  @current_resource.checksum(nil)

  if ::File.exist?(new_resource.path)
    @current_resource.checksum(Chef::Digester.checksum_for_file(new_resource.path))
  end

  @current_resource
end

action :get do
  # We do not want to download the file if we are able to validate the local file if it exists.
  if new_resource.checksum.nil? || new_resource.checksum != current_resource.checksum
    event = "download s3://#{new_resource.bucket}/#{new_resource.key} and store it at #{new_resource.path}"
    converge_by(event) do
      Chef::Log.info(event)
      new_resource.updated_by_last_action(true) if s3_get
    end
  end
end

def s3_get
  cmd = node['awscli']['binary'].dup
  cmd << ' s3 cp '
  cmd << "s3://#{new_resource.bucket}/#{new_resource.key} "
  cmd << new_resource.path
  s3_cmd(cmd)
end

def s3_cmd(command)
  # Setup Environment for aws cli to run in.
  environment = {}
  environment['AWS_DEFAULT_REGION'] = new_resource.region
  environment['AWS_ACCESS_KEY_ID'] = new_resource.aws_access_key_id unless new_resource.aws_access_key_id.nil?
  environment['AWS_SECRET_ACCESS_KEY'] = new_resource.aws_secret_access_key unless new_resource.aws_secret_access_key.nil?

  # Shell out options
  options = { :timeout => new_resource.timeout, :environment => environment }
  shell_out!(command, options)
end
