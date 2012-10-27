#
# Cookbook Name:: wamber
# Recipe:: vm-server
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

%w{ virt-manager qemu-kvm libvirt-bin bridge-utils }.each do |pkg|
	package pkg
end


group "libvirtd" do
	members node["libvirtd-users"]
	append true
end

# the following mostly from 
# http://wiki.libvirt.org/page/Networking#Debian.2FUbuntu_Bridging
execute "stop-network-manager-dispatch" do
	command "/etc/dbus-1/event.d/26NetworkManagerDispatcher stop"
	action :nothing
end

execute "stop-network-manager" do
	command "/etc/dbus-1/event.d/25NetworkManager stop"
	action :nothing
end

file "/etc/default/NetworkManager" do
	content "exit"
	notifies :execute, "execute[stop-network-manager]"
end
file "/etc/default/NetworkManagerDispatcher" do
	content "exit"
	notifies :execute, "execute[stop-network-manager-dispatch]"
end

iface=node[:network_interfaces][node[:hostname]][node[:vm_bridge_iface]]
network_interfaces node[:vm_bridge_iface] do
	target  iface[:target]
	mask    iface[:mask]
	bridge  iface[:bridge]
	network iface[:network]
	gateway iface[:gateway]
	custom  iface[:custom].to_hash
end
