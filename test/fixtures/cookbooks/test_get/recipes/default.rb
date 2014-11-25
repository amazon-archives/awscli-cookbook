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
