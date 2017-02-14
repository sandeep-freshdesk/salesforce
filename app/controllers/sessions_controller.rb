class SessionsController < ApplicationController
  def new
  end

  def create

  	auth_hash = request.env['omniauth.auth']
 	puts "auth_hash = #{auth_hash}"
 	 #render :text => auth_hash.inspect

	redirect_to root_path

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
