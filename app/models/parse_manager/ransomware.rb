class ParseManager::Ransomware

	require 'open-uri'

	HTML = "https://ransomwaretracker.abuse.ch/"
	DATES = 0
	MALWARE = 2
	HOSTNAMES = 3
	IPS = 5

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html
	
	def initialize
		@records = []
		@html = "https://ransomwaretracker.abuse.ch/tracker"
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table.maintable")
		table_with_data.css("tr").each_with_index do |row,index|
			break if index == 30
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			values["malware"] = row_tds[MALWARE].text
			values["hostname"] = row_tds[HOSTNAMES].text.strip
			values["ip"] = ParseManager::ParseHelper.replace_blank_ips (row_tds[IPS].text.split(" ").first)
			values["source_class"] = ParseManager::Ransomware.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
		puts @records.count
	end


end