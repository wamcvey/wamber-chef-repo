#
# Cookbook Name:: netinfo
# Recipe:: defaul
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

include_recipe "network_interfaces"

net_db = data_bag_item("netinfo", node[:netinfo][:bag])
host_info = net_db["hosts"][node[:hostname]]
if host_info 
	net_info = net_db["networks"][host_info["network"]]
	if host_info["interface"]
		network_interfaces host_info["interface"] do
			target  host_info["address"]
			mask    net_info["netmask"]
			network net_info["network"]
			gateway net_info["gateway"]
		end
	end
end
