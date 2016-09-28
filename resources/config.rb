actions :create
default_action :create

attribute :name, :name_attribute => true, :kind_of => String, :required => true
attribute :homedir, :kind_of => String
attribute :region, :kind_of => String
attribute :credentials_databag, :kind_of => String, :required => true
