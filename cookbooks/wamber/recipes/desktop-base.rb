#
# Cookbook Name:: wamber
# Recipe:: desktop-base
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

%w{ calibre mplayer2 terminator chromium-browser meld pidgin pidgin-otr synergy transmission-gtk wireshark vim-gnome }.each do |pkg|
    package pkg
end

if node[:platform] == "ubuntu"
    %w{ breathe-icon-theme community-themes  }.each do |pkg|
        package pkg
    end
end

