name "wamber-dns-dhcp"
description "Installs and configures dnsmasq for DNS & DHCP"

override_attributes(
    "dnsmasq" => {
        "enable_dns" => true,
        "enable_dhcp" => true,
        "dns" => {
            "domain-needed" => nil,
            "bogus-priv" => nil,
            "expand-hosts" => nil,
            "domain" => "home.wamber.net",
	    "server" => ["208.67.222.222", "208.67.220.220"]
        },
        "dhcp" => {
            "dhcp-range" => "10.10.10.196,10.10.10.223,12h",
            "dhcp-option" => ["option:router,10.10.10.1",
                              "option:ntp-server,0.0.0.0,10.10.10.30",
                              "option:domain-search,home.wamber.net"]
        }
    }
)
run_list(
    "recipe[netinfo::etc-hosts]",
    "recipe[dnsmasq]"
) 
