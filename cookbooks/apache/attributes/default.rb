default["apache"]["sites"]["testserver1"] = {"site_title" => "testserver1 website is coming soon", "port" => 80, "domain" => "testserver1.example.com"}
default["apache"]["sites"]["testserver1b"] = {"site_title" =>  "testserver1b website is coming soon", "port" => 80, "domain" => "testserver1b.example.com"}
default["apache"]["sites"]["centosserver3"] = {"site_title" => "centosserver3 website is coming soon", "port" => 80, "domain" => "centosserver3.example.com"}

case node["platform"]
when "centos"
  default["apache"]["package"] = "httpd"
when "ubuntu"
  default["apache"]["package"] = "apache2"
end


