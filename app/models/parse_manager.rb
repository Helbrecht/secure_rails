class ParseManager

	def self.refresh_data(params = {})
		Record.delete_all
		ParseManager::Vxvault.new.parse_sources
		ParseManager::Cctracker.new.parse_sources
		ParseManager::Zeustracker.new.parse_sources
		ParseManager::Bambenek.new.parse_sources
		ParseManager::Alienvault.new.parse_sources
		ParseManager::MalvareDomainUrls.new.parse_sources
	end

end