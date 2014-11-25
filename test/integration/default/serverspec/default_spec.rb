require_relative '../../../kitchen/data/spec_helper'

describe command('pip --version') do
  its(:exit_status) { should eq 0 }
end

describe command('aws --version') do
  its(:exit_status) { should eq 0 }
end
