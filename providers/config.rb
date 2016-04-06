action :create do
  username = new_resource.name
  homedir = new_resource.homedir || "/home/#{username}"
  region = new_resource.region || "us-east-1"
  credentials = Chef::EncryptedDataBagItem.load('secrets', "#{new_resource.credentials_databag}")

  directory "#{homedir}/.aws" do
    owner username
    group username
    mode 0700
  end

  template "#{homedir}/.aws/config" do
    cookbook "awscli"
    source "awscli_config.erb"
    owner username
    group username
    mode 0600
    variables({
      :region => region,
      :credentials => credentials
    })
  end
end
