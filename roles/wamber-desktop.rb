name "wamber-desktop"
description "Role for desktop (machines with a graphical interface) systems"

override_attributes(
	"java" => {
		"install_flavor" => "oracle",
		"oracle" => {
			'accept_oracle_download_terms' => true
		}
	}
)
run_list(
	"role[wamber-base]",
	"recipe[wamber::desktop-base]",
	"recipe[dropbox]",
	"recipe[wamber::java-plugin]"
) 
