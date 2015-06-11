name 'awscli'
maintainer 'Nick Downs'
maintainer_email 'ndowns@amazon.com'
license 'Apache 2.0'
description 'Defines a number of LWRP wrapper commands around the awscli command line script'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.1.1'
source_url 'https://github.com/awslabs/awscli-cookbook' if respond_to?(:source_url)
issues_url 'https://github.com/awslabs/awscli-cookbook/issues' if respond_to?(:issues_url)

supports 'ubuntu'
supports 'centos'

depends 'python', '~> 1.4'
