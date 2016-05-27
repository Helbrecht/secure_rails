
class ParseManager::Zeustracker

	require 'open-uri'

	HTML = "https://zeustracker.abuse.ch"
	DATES = 0
	MALWARE = 1
	HOSTNAMES = 2
	IPS = 3
	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@html = "https://zeustracker.abuse.ch/monitor.php?filter=all"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table") [1]
		table_with_data.css("tr").each_with_index do |row,index|
			break if index == 31
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["malware"] = row_tds[MALWARE].text
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].css("a").text
			values["source_class"] = ParseManager::Zeustracker.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
		puts @records.count
	end
end