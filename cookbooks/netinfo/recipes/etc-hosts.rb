#
# Cookbook Name:: netinfo
# Recipe:: etc-hosts
#
# Copyright 2012, William McVey
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
net_db = data_bag_item("netinfo", node[:netinfo][:bag])
hosts = net_db['hosts'].keys().sort()
hosts.each do |hostname|
	host = net_db['hosts'][hostname]
	hostsfile_entry "#{host['address']}" do
		ip_address "#{host['address']}"
		hostname "#{hostname}.#{net_db['domain']}"
		if host['aliases']
			aliases host['aliases'] + [hostname]
		else
			aliases [hostname]
		end
		if host['comment']
			comment host['comment']
		end
	end
end

