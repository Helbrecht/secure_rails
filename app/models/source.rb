class Source

	include Mongoid::Document

	field :class_name, type: String
	field :malware_params, type: Hash, default: {}
	field :hostname_region_params, type: Hash, default: {}
	field :geo_params, type: Hash, default: {}

	def refresh_statistics!(ip_country, ip_sorted)
		Record.where(source: class_name).each do |record|
			unless record.malware.nil?
				malware_counter = malware_params[record.malware]
				malware_params[record.malware] = malware_counter.nil? ? 1 : malware_counter+1
			end
			# unless ( record.hostname.nil? || URI(record.hostname).host.nil? )
			# 	hostname_region = URI(record.hostname).host.split(".").last
			# 	hostname_region_counter = hostname_region_params[hostname_region]
			# 	hostname_region_params[hostname_region] = hostname_region_counter.nil? ? 1 : hostname_region_counter+1				
			# end
			unless record.ip.nil?
				ip_limit = ip_country[ip_sorted.bsearch{ |x| x <= record.ip}]
				geo_params_counter = geo_params[ip_limit]
				geo_params[ip_limit] = geo_params_counter.nil? ? 1 : geo_params_counter+1
			end
		end
		self.save!
	end

	def get_source_name
		return class_name.gsub("ParseManager::","")
	end

	def records
		Record.where(source: class_name)
	end

end