class ParseManager

	def self.refresh_data(params = {})
		Record.delete_all
		ParseManager::Vxvault.new.parse_sources
		puts "Vxvault done"
		ParseManager::Cctracker.new.parse_sources
		puts "Cctracker done"
		ParseManager::Zeustracker.new.parse_sources
		puts "Zeustracker done"
		ParseManager::Bambenek.new.parse_sources
		puts "Bambenek done"
		ParseManager::Alienvault.new.parse_sources
		puts "Alienvault done"
		ParseManager::MalvareDomainUrls.new.parse_sources
		puts "MalvareDomainUrls done"
		ParseManager::Hphosts.new.parse_sources
		puts "Hphosts done"
		ParseManager::Ransomware.new.parse_sources
		puts "Ransomware done"
		ParseManager::Malwaredb.new.parse_sources
		puts "Malwaredb done"

	end

end