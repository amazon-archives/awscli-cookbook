directory '/tmp/serverspec' do
  recursive true
end

file '/tmp/serverspec/node.json' do
  owner "root"
  mode "0400"
end

ruby_block "dump_node_attributes" do
  block do
    require 'json'

    attrs = Hash.new

    attrs.merge!(node.default_attrs) unless node.default_attrs.empty?
    attrs.merge!(node.normal_attrs) unless node.normal_attrs.empty?
    attrs.merge!(node.override_attrs) unless node.override_attrs.empty?

    attrs['run_list'] = node.run_list.expand(node.chef_environment).recipes

    File.open('/tmp/serverspec/node.json', 'w') { |file| file.write(JSON.pretty_generate(attrs)) }
  end
end
