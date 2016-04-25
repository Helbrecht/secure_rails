class ParseManager::Cert
	require 'open-uri'

	HTML = "http://www.cert.org/downloads/mxlist.ips.txt"
	SOURCE_SCORE = 0.5
	
	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://www.cert.org"
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			values = {}
			values["ip"] = line.strip
			values["source"] = ParseManager::Cert.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
	end
end