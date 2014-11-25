require_relative '../../../kitchen/data/spec_helper'

describe file('/tmp/testenv/bin/aws') do
  it { should be_file }
  it { should be_executable }
end
