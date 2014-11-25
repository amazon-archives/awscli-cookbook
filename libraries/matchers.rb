if defined?(ChefSpec)
  def get_awscli_s3_file(path)
    ChefSpec::Matchers::ResourceMatcher.new(:awscli_s3_file, :get, path)
  end
end
