class Record

	include Mongoid::Document

	DATE_SCORE = 10
	HOST_SCORE = 20
	TYPE_SCORE = 20
	IP_SCORE = 50

	field :ip, type: String
	field :date
	field :hostname, type: String
	field :score, type: String
	field :type, type: String
	field :source

	field :source_html, type: String

	index ({score: 1, hostname: 1, date: 1, ip: 1})

	def to_s
		"#{@ip} #{@hostname} #{@type}"
	end

	def get_score
		score = 0
		score += self.date.nil? ? 0 : DATE_SCORE
		score += self.hostname.nil? ? 0 : HOST_SCORE
		score += self.type.nil? ? 0 : TYPE_SCORE
		score += ( self.ip.nil? || self.ip == "" ) ? 0 : IP_SCORE
		score *= get_score_for_source
		self.score = score
	end


	def get_score_for_source
		return self.source.constantize::SOURCE_SCORE
	end


end