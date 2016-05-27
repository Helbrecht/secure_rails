

class ParseManager::Alienvault

	require 'open-uri'

	HTML = "http://reputation.alienvault.com/reputation.generic"
	THREAT = 2
	IPS = 0
	SOURCE_SCORE = 0.75
	
	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://reputation.alienvault.com"
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			next if line_count < 9
			info = line.split(" ")
			values = {}
			values["threat"] = info[THREAT]
			values["ip"] = info[IPS]
			values["source_class"] = ParseManager::Alienvault.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 20
		end
		@records.map(&:save!)
		puts @records.count
	end
end