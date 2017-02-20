class Authorization < ActiveRecord::Base
	belongs_to :user

	def self.createProvider(auth_hash, user)
		puts "user.id = #{user.id}"
		create :provider => auth_hash['provider'], :uid => auth_hash['uid'], :user_id => user.id, :refresh_token => auth_hash['credentials']['refresh_token'] 
	end
end
