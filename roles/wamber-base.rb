name "wamber-base"
description "Role for all wamber systems"

override_attributes(
	"network_interfaces" => {
		"replace_orig" => true
	},
	"netinfo" => {
		"bag" => "wamber-home"
	},
	"java" => {
		"install_flavor" => "oracle",
		"oracle" => {
			'accept_oracle_download_terms' => true
		}
	},
	"chef_client" => {
		"server_url" => "http://chef.home.wamber.net:4000/",
		"cache_path" => "/var/cache/chef",
		"backup_path" => "/var/lib/chef/backup"
	}
)
run_list(
	"recipe[wamber::base]",
	"recipe[networking_basic]",
	"recipe[netinfo]",
	"recipe[chef-client::service]",
	"recipe[java]"
) 
