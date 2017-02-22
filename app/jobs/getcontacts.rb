class Getcontacts
  @queue = :sleepBeforeContacts
  #bundle exec rake environment resque:work QUEUE=sleep 
  # by using above command worker will pop this job from queuq and start working on it
 
  def self.perform(contacts)
  	puts "workder pop this job from queue and started this job"
	contacts.each do |contact|
	  		puts "new one #{contact}"
	  		contact ={
	  			:FirstName => contact["FirstName"],
	  			:LastName => contact["LastName"]
	  		}
	  		cont = Contact.new(contact)
	  		puts "cont = #{cont}"
	  		cont.save
	  		puts "added one more contact"
	end
  end
end