module SessionsHelper
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]

		cookies.signed[:remember_token] = [user.id, user.salt]
		current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def current_user

		if cookies.signed[:remember_token] &&  cookies.signed[:remember_token][0] &&  ((cookies.signed[:remember_token][0]).is_a? Integer)
			@current_user ||= user_from_remember_token
		elsif cookies.signed[:remember_token] &&  cookies.signed[:remember_token][1] && ((cookies.signed[:remember_token][1]).is_a? Integer)
			@current_user = Authuser.find(cookies.signed[:remember_token][1])
		else
			@current_user ||= user_from_remember_token
		end
		@current_user
	end


	def current_user?(user)
		user == current_user
	end

	def signed_in?
		!current_user.nil?
	end

	def sign_out
		session[:authuser_id] = nil
		cookies.delete(:remember_token)
		current_user = nil
	end

	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
#form here starting for omni auth public methods
	
	def omnisign_in(authuid, provider, authuser)
		#cookies.permanent.signed[:remember_token] = [authuser.id, authuid]

		cookies.signed[:remember_token] = [provider, authuser.id]
		current_user = authuser
		#current_user = Authuser.find(sessionId)

	end


	private

		def user_from_remember_token
			User.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end

		def store_location
		session[:return_to] = request.fullpath
		end
		def clear_return_to
		session[:return_to] = nil
		end
end