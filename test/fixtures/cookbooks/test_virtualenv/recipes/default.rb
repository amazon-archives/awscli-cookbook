include_recipe 'python::virtualenv'

python_virtualenv '/tmp/testenv' do
  owner 'root'
  group 'root'
  action :create
end

node.set['awscli']['virtualenv'] = '/tmp/testenv'

include_recipe 'awscli::default'
