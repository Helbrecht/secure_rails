

class ParseManager::Alienvault

	require 'open-uri'

	HTML = "http://reputation.alienvault.com/reputation.generic"
	TYPES = 2
	IPS = 0
	SOURCE_SCORE = 0.75
	
	attr_accessor :records

	def initialize
		@records = []
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			next if line_count < 9
			info = line.split(" ")
			values = {}
			values["type"] = info[TYPES]
			values["ip"] = info[IPS]
			values["source"] = ParseManager::Alienvault.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
			break if line_count == 20
		end
		@records.map(&:save!)
	end
end