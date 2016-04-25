class ParseManager::Hphosts

	require 'open-uri'
	
	HTML = "http://hosts-file.net"
	DATES = 4
	THREAT = 3
	HOSTNAMES = 1
	IPS = 2

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		@year = 2016
		@order = "DESC"
		@page = 1
		@html = "#{HTML}/?#{URI.encode_www_form({"s"=>"Browse","f"=>@year,"o"=>@order,"page"=>@page})}"
	end

	def reset_counter
		@skip = 0
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table.main_normal")
		table_with_data.css("tr").each_with_index do |row,index|
			break if index == 30
			next if index == 0 || index == 1
		# puts page.css("table")[1].css("tr").first.css("td").first
		# table_with_data = page.css("table").first
		# 
		# 	next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["threat"] = row_tds[THREAT].text
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].css("a").text
			values["source"] = ParseManager::Hphosts.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
		puts @records.count
	end
end	