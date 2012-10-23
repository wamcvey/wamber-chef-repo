name "wamber-desktop"
description "Role for desktop (machines with a graphical interface) systems"
run_list(
	"recipe[wamber::base]",
	"recipe[wamber::desktop-base]",
	"recipe[dropbox]"
) 
