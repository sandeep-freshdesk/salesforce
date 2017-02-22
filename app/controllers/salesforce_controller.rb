class SalesforceController < ApplicationController


		#def index
		#client = Databasedotcom::Client.new :client_id => "3MVG9YDQS5WtC11rEEbuE0ugmmxoFqE2nwkWgPIMnmmss56M7Lc90J0wULBI3_zBVbQy7Fh9ralCsTnz7DGt6", :client_secret => "201586777941315632"
		#client = Databasedotcom::Client.new("databasedotcom.yml")
		#puts "#{client}"
		#Salesforce::Contact.all
   	 	#@contacts = Contact.all
		#end
		
	 def index
  		 new_access_token_hash = getNewAccessToken
		 puts "access_token = #{new_access_token_hash['access_token']}"
		 puts "current_user = #{current_user} && #{current_user.authorizations}"
		 refresh_token = get_refresh_token
		
		 puts "refresh_token === #{refresh_token}"
		 @client = Force.new instance_url:  new_access_token_hash['instance_url'],
	                          oauth_token:   new_access_token_hash['access_token'],
	                          refresh_token: refresh_token,
	                          client_id:     "3MVG9YDQS5WtC11rEEbuE0ugmmxoFqE2nwkWgPIMnmmss56M7Lc90J0wULBI3_zBVbQy7Fh9ralCsTnz7DGt6",
	                          client_secret: "201586777941315632"
	 	 
	 	 puts "@client = #{@client}"
	 	 @accounts= @client.query("select Id, Name from Account")
  		 contacts = @client.query("select FirstName, LastName FROM Contact")
  		  puts "contacts ====== #{contacts}"
	 	 Resque.enqueue(Getcontacts, contacts)
	 	 
  	  end

  	  def getNewAccessToken	
  	  	refresh_token = get_refresh_token
		resp = HTTParty.post("https://login.salesforce.com/services/oauth2/token?grant_type=refresh_token&client_id=3MVG9YDQS5WtC11rEEbuE0ugmmxoFqE2nwkWgPIMnmmss56M7Lc90J0wULBI3_zBVbQy7Fh9ralCsTnz7DGt6&client_secret=201586777941315632&refresh_token=" + refresh_token )
		puts "resp = #{resp}"
		resp	
	  end

	  def get_refresh_token
	  	refresh_token = ''
		 if current_user.authorizations
		 	current_user.authorizations.each do |authorization|
		 		if authorization['provider'] == params[:provider]
		 			refresh_token = authorization['refresh_token']
		 		end
		 	end
		 end
		 refresh_token
	  end

	  

    def show
    end
end
