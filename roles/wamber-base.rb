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
	}
)
run_list(
	"recipe[wamber::base]",
	"recipe[networking_basic]",
	"recipe[netinfo]",
	"recipe[java]"
) 
