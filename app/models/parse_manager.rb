class ParseManager

	def self.refresh_data(params = {})
		Record.delete_all
		# ParseManager::Vxvault.new.parse_sources
		# puts "Vxvault done"
		# ParseManager::Cctracker.new.parse_sources
		# puts "Cctracker done"
		# ParseManager::Feodo.new.parse_sources
		# puts "Feodo done"
		# ParseManager::Asprox.new.parse_sources
		# puts "Asprox done"
		# ParseManager::Autoshun.new.parse_sources
		# puts "Autoshun done"
		# ParseManager::Zeustracker.new.parse_sources
		# puts "Zeustracker done"
		# ParseManager::BambenekDomainList.new.parse_sources
		# puts "Bambenek domain done"
		# ParseManager::BambenekDgaList.new.parse_sources
		# puts "Bambenek dga done"
		# ParseManager::BambenekIpList.new.parse_sources
		# puts "Bambenek ip done"
		# ParseManager::Alienvault.new.parse_sources
		# puts "Alienvault done"
		# ParseManager::MalvareDomainUrls.new.parse_sources
		# puts "MalvareDomainUrls done"
		# ParseManager::Hphosts.new.parse_sources
		# puts "Hphosts done"
		# ParseManager::Ransomware.new.parse_sources
		# puts "Ransomware done"
		# ParseManager::Malwaredb.new.parse_sources
		# puts "Malwaredb done"
		# ParseManager::Palevo.new.parse_sources
		# puts "Palevo done"
		# ParseManager::Phishtank.new.parse_sources
		# puts "Phishtank done"
		# ParseManager::ThreatcrowdIp.new.parse_sources
		# puts "ThreatcrowdIp done"
		# ParseManager::ThreatcrowdDomain.new.parse_sources
		# puts "ThreatcrowdDomain done"
		# ParseManager::BlocklistDeIp.new.parse_sources
		# puts "BlocklistDeIp done"
		ParseManager::Botscout.new.parse_sources
		puts "Botscout done"
	end

end