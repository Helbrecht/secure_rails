class ParseManager::Phishtank

	require 'open-uri'
	require 'csv'
	HTML = "http://data.phishtank.com/data/online-valid.csv"
	DATES = 5
	HOSTNAMES = 1
	SOURCE_SCORE = 1

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "http://phishtank.com"
	end

	def parse_sources

		open('online-valid.txt', 'wb') do |file|
  			file << open('http://data.phishtank.com/data/online-valid.csv').read
  		end

  		myfile = File.open("online-valid.txt")
  		line_count = 0
		myfile.each_line do |line|
			line_count += 1
			next if line_count < 1
			info = line
			splitted_info = info.split(",")
			values = {}
			values["threat"] = "Phishing"
			values["hostname"] = splitted_info[HOSTNAMES]
			values["date"] = splitted_info[DATES].gsub("T"," ").gsub("+00:00","")
			values["source"] = ParseManager::Phishtank.to_s
			values["source_html"] = html
			@records << Record.new(values)
			break if line_count == 30
		end
		@records.map(&:save!)
		puts @records.count
 	end
end


