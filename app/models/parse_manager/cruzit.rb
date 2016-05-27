class ParseManager::Cruzit

	require 'open-uri'
	HTML = "http://www.cruzit.com/xwbl2txt.php"
	DATES = 5
	HOSTNAMES = 1
	SOURCE_SCORE = 1

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://www.cruzit.com"
	end

	def parse_sources

		open('ipadress_list.txt', 'wb') do |file|
  			file << open(HTML).read
  		end

  		myfile = File.open("ipadress_list.txt")
  		line_count = 0
		myfile.each_line do |line|
			line_count += 1
			next if line_count < 2 
			values = {}
			values["ip"] = line.strip
			values["source_class"] = ParseManager::Cruzit.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
 	end
end