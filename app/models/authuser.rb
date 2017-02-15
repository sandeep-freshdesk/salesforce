class Authuser < ActiveRecord::Base
	has_many :authorizations
	validates :name, :email, :presence => true


	def add_provider(auth_hash)
	  # Check if the provider already exists, so we don't add it twice
	  unless authorizations.find_by_provider_and_authuid(auth_hash["provider"], auth_hash["uid"])
	    Authorization.create :authuser => self, :provider => auth_hash["provider"], :authuid => auth_hash["uid"]
	  end
	  puts "self in add_provider ======#{self}"
	  self
	end
end
