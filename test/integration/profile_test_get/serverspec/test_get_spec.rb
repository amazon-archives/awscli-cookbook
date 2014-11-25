require_relative '../../../kitchen/data/spec_helper'
require 'json'

node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))

describe file('/tmp/testfile') do
  it { should be_file }
  its(:sha256sum) { should eq node['test_get']['checksum'] }
end
