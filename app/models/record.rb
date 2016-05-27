class Record

	include Mongoid::Document

	DATE_SCORE = 10
	HOST_SCORE = 20
	MALWARE_SCORE = 20
	THREAT_SCORE = 15
	IP_SCORE = 35

	field :ip, type: String
	field :date
	field :hostname, type: String
	field :score, type: String
	field :malware, type: String
	field :threat, type: String
	field :source_class

	field :source_html, type: String

	index ({score: 1, hostname: 1, date: 1, ip: 1, })

	def to_s
		"#{@ip} #{@hostname} #{@type}"
	end

	def get_score
		score = 0
		score += self.date.nil? ? 0 : DATE_SCORE
		score += self.hostname.nil? ? 0 : HOST_SCORE
		score += self.malware.nil? ? 0 : MALWARE_SCORE
		score += self.threat.nil? ? 0 : THREAT_SCORE
		score += ( self.ip.nil? || self.ip == "" ) ? 0 : IP_SCORE
		score *= get_score_for_source
		self.score = score
	end

	def get_score_for_source
		return self.source_class.constantize::SOURCE_SCORE
	end

	def get_ip_from_domain
		if ip.blank?
			ping_result = `ping -c 1 #{self.hostname}`
			self.ip = ping_result.split(" ")[2].gsub("(","").gsub(")","")
			self.save!
		end
	end

end