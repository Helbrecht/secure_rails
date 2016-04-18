
class ParseManager::Bambenek

	require 'open-uri'

	HTML = "http://osint.bambenekconsulting.com/feeds/c2-dommasterlist.txt"
	DATES = 2
	MALWARE = 1
	HOSTNAMES = 0
	SOURCE_SCORE = 0.5
	
	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://osint.bambenekconsulting.com"
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
			values["malware"] = splitted_info[MALWARE]
			values["hostname"] = splitted_info[HOSTNAMES]
			values["date"] = splitted_info[DATES]
			values["source"] = ParseManager::Bambenek.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
	end
end
