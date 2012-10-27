name "wamber-vm-server"
description "Role for servers providing virtual hosts/images to wamber.net"

override_attributes(
)
run_list(
	"recipe[wamber::vm-server]" 
) 
