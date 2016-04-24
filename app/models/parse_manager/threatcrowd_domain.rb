class ParseManager::ThreatcrowdDomain
	require 'open-uri'

	HTML = "https://www.threatcrowd.org/feeds/domains.txt"
	SOURCE_SCORE = 0.5
	
	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "https://www.threatcrowd.org"
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			values = {}
			values["hostname"] = line.strip
			values["source"] = ParseManager::ThreatcrowdDomain.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
	end
end	