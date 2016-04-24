class ParseManager::ParseHelper

	def self.replace_blank_ips (ip_string)
		return nil if ip_string == "(n/a)"
		return nil if ip_string == "n/a"
		return ip_string
	end

	def self.replace_blank_hostnames (hostname_string)
		return nil if hostname_string.empty?
		return hostname_string
	end
end