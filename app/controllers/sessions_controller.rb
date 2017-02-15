class SessionsController < ApplicationController
  def new
		cookies.delete(:remember_token)
  end

  def create

  	auth_hash = request.env['omniauth.auth']
  	puts "auth_hash #{auth_hash}"
  	if auth_hash	
	 	
		if session[:authuser_id] && ((session[:authuser_id]).is_a? String)
			
		    # Means our user is signed in. Add the authorization to the user
		    auser = Authuser.find(session[:authuser_id]).add_provider(auth_hash)
		    puts "iiffff = #{auser}"

		 	redirect_to root_path
		    #render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
		else
		    # Log him in or sign him up
		    auth = Authorization.find_or_create(auth_hash)
		 	puts "s\nauth======#{auth}"
		    # Create the session
		    session[:authuser_id] = auth.authuser.id
		 	redirect_to root_path
	    	# :text => "Welcome #{auth.user.name}!"
	    end

	    authuser = Authuser.find(session[:authuser_id])
	    puts "provider = #{auth_hash["provider"]}"
	    puts "uid = #{auth_hash["uid"]}"
	    puts "authuser = #{authuser.name} email #{authuser.email}"
	    omnisign_in(auth_hash["uid"], auth_hash["provider"], authuser)
	    puts "last"
	else
		user = User.authenticate(params[:session][:email], params[:session][:password])
		if user.nil?
		flash.now[:error] = "Invalid email/password combination."
		@title = "Sign in"
		render 'new'
		else
		sign_in user
		redirect_back_or user
		end
	end










=begin


  	auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_authuid(auth_hash["provider"], auth_hash["uid"])
	if @authorization
		redirect_to root_path
       #render :text => "Welcome back #{@authorization.authuser.name}! You have already signed up."
    else
	   authuser = Authuser.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
	   authuser.authorizations.build :provider => auth_hash["provider"], :authuid => auth_hash["uid"]
	  	
	   authuser.save
	   redirect_to root_path
	   #render :text => "Hi #{user.name}! You've signed up."
    end
=end

 	 #render :text => auth_hash.inspect

	#redirect_to root_path

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
  end


  def destroy
		sign_out
		redirect_to root_path
	end
end
