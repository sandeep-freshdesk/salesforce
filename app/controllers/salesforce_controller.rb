class SalesforceController < ApplicationController

	include Databasedotcom::Rails::Controller

	def index
		puts "index =========="
   	 	@contacts = Contact.all
   		puts "	 @contacts  = #{@contacts}"
	end

    def show
    end
end