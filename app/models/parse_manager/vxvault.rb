

class ParseManager::Vxvault

	require 'open-uri'

	HTML = "http://vxvault.net"
	DATES = 0
	HOSTNAMES = 1
	IPS = 3

	SOURCE_SCORE = 1.0

	attr_accessor :records
	attr_accessor :html

	def initialize
		@records = []
		@skip = 0
		@mass = 100
		@html = "#{HTML}/ViriList.php?#{URI.encode_www_form({"s"=>@skip,"m"=>@mass})}"
	end

	def get_more
		#formatted_skip = URI.encode_www_form(  )
		#@skip += 100
		#return formatted_skip
	end

	def reset_counter
		@skip = 0
	end

	def parse_sources
		page = Nokogiri::HTML(open(html))
		table_with_data = page.css("table").first
		table_with_data.css("tr").each_with_index do |row,index|
			break if index == 30
			next if index == 0
			row_tds = row.css("td")
			values = {}
			values["date"] = row_tds[DATES].text
			#values["type"] = row_tds[TYPES].text
			values["hostname"] = row_tds[HOSTNAMES].text.gsub!('[D] ','')
			values["ip"] = row_tds[IPS].css("a").text
			values["source_class"] = ParseManager::Vxvault.to_s
			values["source_html"] = HTML
			@records << Record.new(values)
		end
		@records.map(&:save!)
		puts @records.count
	end


end