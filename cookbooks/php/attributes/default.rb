case node["platform"]
when "centos"
	default["php"]["package"] = "php"
when "ubuntu"
	default["php"]["package"] = "php5"
end
