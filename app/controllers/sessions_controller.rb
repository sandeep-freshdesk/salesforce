class SessionsController < ApplicationController
  def new
  end

  def login
  	redirect_to '/auth/salesforce'
  end

  def create
	auth_hash = request.env['omniauth.auth']
	puts "auth_hash #{auth_hash.to_json}"
	if auth_hash
		puts "auth_hash #{auth_hash['info']}"
		flash[:success] = "through provider you are successfuly loggedin to the Sample App!"

		@authorization = Authorization.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])
		if @authorization
			puts "auth find ======="
			user = @authorization.user
			sign_in user	
			flash[:success] = "User is saved in sample App"
			redirect_back_or user
		else
			user = User.find_by_email(auth_hash['info']['email'])
			puts "user find =======#{user}"
			if user
				Authorization.createProvider(auth_hash['provider'], auth_hash['uid'], user)
				sign_in user	
				flash[:success] = "User is saved in sample App"
				redirect_back_or user
			else
				user = User.new({:name => auth_hash['info']['name'], :email => auth_hash['info']['email']})
				if user.save
					Authorization.createProvider(auth_hash['provider'], auth_hash['uid'], user)
					sign_in user	
					flash[:success] = "User is saved in sample App"
					redirect_back_or user
				else

					flash[:success] = "User is NOT saved in sample App"
					redirect_to root_path 
				end
			end	
			
		end
	else
		puts "ccccc #{params}"
		puts ="pdfsd paramssession = #{params[:session][:email]} sdfsdfspass "
		puts ="password paramssession = #{params[:session][:password]} password "
		user = User.authenticate(params[:session][:email],params[:session][:password])
		if user.nil?
			flash.now[:error] = "Invalid email/password combination."
			@title = "Sign in"
			render 'new'
		else

			puts "ccccc #{params}"
			sign_in user
			redirect_back_or user
		end
	end

	#redirect_to root_path 

  end
=begin

	user = User.authenticate(params[:session][:email],
	params[:session][:password])
	if user.nil?
		flash.now[:error] = "Invalid email/password combination."
		@title = "Sign in"
		render 'new'
	else
		sign_in user
		redirect_back_or user
	end
=end
 


  def destroy
	sign_out
	redirect_to root_path
  end
end
