include_recipe 'awscli::default'

# Awscli should pull credentials from the metadata profile if no creds
# are set.
awscli_s3_file "/tmp/testfile" do
  bucket node['test_get']['bucket']
  key node['test_get']['key']
  checksum node['test_get']['checksum']
end
