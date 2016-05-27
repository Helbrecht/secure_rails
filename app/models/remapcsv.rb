class Remapcsv

	def remap
		out_data = []
		CSV.foreach("GeoIPCountryWhois.csv") do |row|
			out_data << "#{format_ip(row[0])},#{row[5]}"
		end
		File.write("ip_country.csv", out_data.join("\n") )
	end

	def format_ip(ip)
		ip_out = []
		ip_parts = ip.split(".")
		ip_parts.each do |part|
			ip_out << "0"*(3-part.to_s.length)+ part.to_s
		end
		return ip_out.join(".")
	end

end