class ParseManager::Botscout
	require 'open-uri'

	HTML = "http://botscout.com"
	DATES = 1
	IPS = 4

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		
		@html = "#{HTML}/last.htm"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table").first
		table_with_data.css("tr").each_with_index do |row,index|
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text.gsub(" PM","").gsub(" AM","")
			values["threat"] = "Bot"
			values["ip"] = row_tds[IPS].text
			next if values["ip"] == "(empty)"
			values["source_class"] = ParseManager::Botscout.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
			break if index == 30
		end
		@records.map(&:save!)
		puts @records.count
	end



end