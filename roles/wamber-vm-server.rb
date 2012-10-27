name "wamber-vm-server"
description "Role for servers providing virtual hosts/images to wamber.net"

override_attributes({
    "libvirtd-users" => ["wam"],
    "vm_bridge_iface" => "br0",
    "network_interfaces" => {
        "quantum" => {
            "br0" => {
                "target" => "10.10.10.30",
                "network" => "10.10.10.0",
                "mask" => "255.255.255.0",
                "gateway" => "10.10.10.1",
                "broadcast" => "10.10.10.255",
                "bridge" => ["eth0"],
                :custom => {
                    "bridge_stp" => "on",
                    "bridge_maxwait" => "0"
                }
            }
        }
    },
    "sysctl" => {
        "net" => {
            "bridge" => {
                "bridge-nf-call-ip6tables" => 0,
                "bridge-nf-call-iptables" => 0,
                "bridge-nf-call-arptables" => 0
            }
        }
    }
})
run_list(
    "recipe[network_interfaces]",
    "recipe[wamber::vm-server]",
    "recipe[sysctl]" 
) 
