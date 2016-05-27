class Classifier

	def load_as_csv
		countries = get_all_countries(Source.all)
		csv_header = get_csv_header(countries)
		csv_body = []
		Source.all.each do |source|
			csv_line = []
			countries.each do |country|
				country_data = source.geo_params[country]
				if country_data.nil?
					csv_line << ["0"]
				else
					csv_line << [country_data.to_s]
				end
			end
			csv_body << ([source.get_source_name] + csv_line).join(",")
		end

		File.write('data_for_class.csv', ([csv_header] + csv_body).join("\n"))
	end

	def get_all_countries(sources)
		return sources.map(&:geo_params).map(&:keys).flatten.uniq
	end

	def get_csv_header(countries)
		return(["source"] + countries).join(",")
	end

end