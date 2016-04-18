
class ParseManager::Zeustracker

	require 'open-uri'

	HTML = "https://zeustracker.abuse.ch/monitor.php"
	DATES = 0
	TYPES = 1
	HOSTNAMES = 2
	IPS = 3
	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
	end

	def parse_sources
		page = Nokogiri::HTML(open(HTML))
		table_with_data = page.css("table") [1]
		table_with_data.css("tr").each_with_index do |row,index|
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["type"] = row_tds[TYPES].text
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].css("a").text
			values["source"] = ParseManager::Zeustracker.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
	end
end