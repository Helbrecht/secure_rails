
class ParseManager::Bambenek

	require 'open-uri'

	HTML = "http://osint.bambenekconsulting.com/feeds/c2-dommasterlist.txt"
	DATES = 2
	TYPES = 1
	HOSTNAMES = 0
	SOURCE_SCORE = 0.5
	
	attr_accessor :records

	def initialize
		@records = []
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			next if line_count < 17
			info = line.gsub("Domain used by ","")
			splitted_info = info.split(",")
			values = {}
			values["type"] = splitted_info[TYPES]
			values["hostname"] = splitted_info[HOSTNAMES]
			values["date"] = splitted_info[DATES]
			values["source"] = ParseManager::Bambenek.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
			break if line_count == 24
		end
		@records.map(&:save!)
	end
end
