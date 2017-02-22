class Contact < ActiveRecord::Base
	def self.saveAllContacts(contacts)
		puts "came in saveAllContacts"
		
		# contacts.each do |contact|
	 #  		puts "new one #{contact}"
	 #  		contact ={
	 #  			:FirstName => contact["FirstName"],
	 #  			:LastName => contact["LastName"]
	 #  		}
	 #  		cont = Contact.new(contact)
	 #  		puts "cont = #{cont}"
	 #  		cont.save
	 #  		puts "added one more contact"
		# end
	end
end
