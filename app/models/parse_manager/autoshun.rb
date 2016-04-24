class ParseManager::Autoshun
	require 'open-uri'

	HTML = "http://autoshun.org"
	DATES = 1
	THREAT = 2
	IPS = 0

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		@html = "#{HTML}/files/shunlist.html"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("td")[4..-1]
		table_with_data.each_slice(3).to_a.each_with_index do |row,index|
			values = {}
			values["date"] = row[DATES].text
			values["threat"] = row[THREAT].text
			values["ip"] = row[IPS].text
			values["source"] = ParseManager::Autoshun.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
			break if index == 22
		end
		@records.map(&:save!)
		puts @records.count
	end


end