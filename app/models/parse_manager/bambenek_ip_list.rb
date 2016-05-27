
class ParseManager::BambenekIpList

	require 'open-uri'

	HTML = "http://osint.bambenekconsulting.com/feeds/c2-ipmasterlist.txt"
	DATES = 2
	MALWARE = 1
	IPS = 0
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
			info = line.gsub("IP used by ","")
			splitted_info = info.split(",")
			values = {}
			values["malware"] = splitted_info[MALWARE]
			values["ip"] = splitted_info[IPS]
			values["date"] = splitted_info[DATES]
			values["source_class"] = ParseManager::BambenekIpList.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
	end
end