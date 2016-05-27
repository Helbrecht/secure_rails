class ParseManager::DangerRulezSk

	require 'open-uri'

	HTML = "http://danger.rulez.sk/projects/bruteforceblocker/blist.php"
	DATES = 1
	IPS = 0
	SOURCE_SCORE = 0.75
	
	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://danger.rulez.sk"
	end

	def parse_sources
		text = open(HTML).read
		line_count = 0
		text.each_line do |line|
			line_count += 1
			next if line_count < 2
			info = line.split("# ")
			values = {}
			values["threat"] = "Bruteforce"
			values["ip"] = info[IPS].strip
			values["date"] = info[DATES][0,19]
			values["source_class"] = ParseManager::DangerRulezSk.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 20
		end
		@records.map(&:save!)
		puts @records.count
	end
end