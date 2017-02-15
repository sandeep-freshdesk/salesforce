class Authorization < ActiveRecord::Base
	belongs_to :authuser
	validates :provider, :authuid, :presence => true

	def self.find_or_create(auth_hash)
	  unless auth = find_by_provider_and_authuid(auth_hash["provider"], auth_hash["uid"])
	    auser = Authuser.create :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
	    auth = create :authuser => auser, :provider => auth_hash["provider"], :authuid => auth_hash["uid"]
	  end
	 
	  auth
	end
end
	