#
# Cookbook Name:: redis-server
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# bash 'Adding Redis PPA and Installing Package' do user 'root'
# 	code <<-EOC
# 	    apt-get install -y python-software-properties
# 	    add-apt-repository -y ppa:chris-lea/redis-server
# 	    apt-get update
# 	    apt-get install -y redis-server
# 	EOC
# end

apt_repository 'redis-server' do 
  uri			'ppa:chris-lea/redis-server' 
  distribution	node['lsb']['codename']
end

package 'redis-server'

template "/etc/init.d/redis-server" do 
	owner "redis"
	group "redis"
	mode "0755"
	source "redis-server.erb"
	notifies :run, "execute[restart-redis]", :immediately 
end

template "/etc/redis/redis.conf" do 
	owner "redis"
	group "redis"
	mode "0644"
	source "redis.conf.erb" 
end

directory "/etc/redis" do owner 'redis'
	group 'redis'
	action :create
end

execute "restart-redis" do
	command "/etc/init.d/redis-server restart" 
	action :nothing
end



# bash 'Restarting Redis' do user 'root'
# 	code <<-EOC
# 	    /etc/init.d/redis-server restart
# 	EOC
# end










