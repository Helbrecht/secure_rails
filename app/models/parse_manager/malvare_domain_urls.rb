

class ParseManager::MalvareDomainUrls

	require 'open-uri'

	HTML = "http://www.malwaredomainlist.com"
	DATES = 0
	TYPES = 4
	HOSTNAMES = 1
	IPS = 2

	SOURCE_SCORE = 0.9

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@quantity = 50
		@html = "#{HTML}/mdl.php?#{URI.encode_www_form({"quantity"=>@quantity})}"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table") [1]
		table_with_data.css("tr").each_with_index do |row,index|
			next if index < 2
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["type"] = row_tds[TYPES].text #unless row_tds[TYPES].text == "-"
			values["hostname"] = row_tds[HOSTNAMES].text
			values["ip"] = row_tds[IPS].text
			values["source"] = ParseManager::MalvareDomainUrls.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
			break if index > 10
		end
		@records.map(&:save!)
	end


end