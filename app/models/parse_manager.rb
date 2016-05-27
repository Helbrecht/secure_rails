class ParseManager

	SOURCES_NAMES = [
		"ParseManager::Vxvault",
		"ParseManager::Cctracker",
		"ParseManager::Feodo",
		"ParseManager::Asprox",
		"ParseManager::Autoshun",
		"ParseManager::Zeustracker",
		"ParseManager::BambenekDomainList",
		"ParseManager::BambenekDgaList",
		"ParseManager::BambenekIpList",
		"ParseManager::Alienvault",
		"ParseManager::DangerRulezSk",
		"ParseManager::MalvareDomainUrls",
		"ParseManager::Hphosts",
		"ParseManager::Ransomware",
		"ParseManager::Malwaredb",
		"ParseManager::Palevo",
		"ParseManager::Phishtank",
		#"ParseManager::Cruzit",
		"ParseManager::ThreatcrowdIp",
		"ParseManager::ThreatcrowdDomain",
		"ParseManager::BlocklistDeIp",
		"ParseManager::Botscout",
		"ParseManager::Cert",
		"ParseManager::Chaos",
		"ParseManager::Cinscore"
	]

	def self.delete_and_refresh_data(params = {})
		Record.delete_all
		SOURCES_NAMES.each do |source_name|
			source_name.constantize.new.parse_sources
			puts source_name.gsub("ParseManager::","") + " done"
		end
	end

	def self.create_sources
		Source.delete_all
		SOURCES_NAMES.each do |source_name|
			Source.new(class_name: source_name).save!
		end
	end

	def self.count_statistics_for_sources
		ip_country, ip_sorted = read_geo_csv 
		ip_reverse_sorted = ip_sorted.reverse
		Source.each do |source|
			source.refresh_statistics!(ip_country, ip_reverse_sorted)
		end
	end

	def self.read_geo_csv
		ip_country = {}
		ip_sorted = []
		CSV.foreach("ip_country.csv") do |row|
			ip_sorted << row.first
			ip_country[row.first] = row.last
		end
		return ip_country, ip_sorted
	end

private


end
