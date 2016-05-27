class ParseManager::Palevo

	require 'open-uri'

	HTML = "https://palevotracker.abuse.ch/"
	DATES = 0
	MALWARE = 3
	HOSTNAMES = 1
	IPS = 2

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		@html = "#{HTML}"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table").first
		table_with_data.css("tr").each_with_index do |row,index|
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["malware"] = "Palevo C&C"
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].css("a").text
			values["source_class"] = ParseManager::Cctracker.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
		puts @records.count
	end
end