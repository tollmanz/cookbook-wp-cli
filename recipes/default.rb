#
# Cookbook Name:: wp-cli
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Create needed directories
%w{/var/src /var/receipts}.each do |dirname|
directory dirname do
	owner "root"
		group "root"
		mode 00755
		action :create
		recursive true
	end
end

# Clone the repo if it doesn't exist
execute "clone wp-cli repository" do
	command "git clone --recursive git://github.com/wp-cli/wp-cli.git /var/src/wp-cli"
	creates '/var/src/wp-cli/.git'
	action :run
end

# Build wp-cli if it isn't built yet
execute "build wp-cli" do
	command "cd /var/src/wp-cli/ && sudo utils/dev-build"
	creates '/usr/bin/wp'
	action :run
end

# Update the cli tools
execute "fetch wp-cli updates" do
	command "git --git-dir=/var/src/wp-cli/.git fetch"
	action :run
end
