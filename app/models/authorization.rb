class Authorization < ActiveRecord::Base
	belongs_to :user

	def self.createProvider(provider, uid, user)
		puts "user.id = #{user.id}"
		create :provider => provider, :uid => uid, :user_id => user.id 
	end
end
