module SessionsHelper
	def sign_in(user)
		puts " sign_in "
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user
	end

	def current_user=(user)
		puts " current_user "
		@current_user = user
	end

	def current_user
		puts " current_user "
		@current_user ||= user_from_remember_token
	end

	def current_user?(user)
		puts " current_user?( "
		user == current_user
	end

	def signed_in?
		puts " signed_in? "
		!current_user.nil?
	end

	def sign_out
		puts " sign_out "
		cookies.delete(:remember_token)
		current_user = nil
	end

	def deny_access
		puts " deny_access "
		store_location
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end

	def redirect_back_or(default)
		puts " redirect_back_or "
		redirect_to(session[:return_to] || default)
		clear_return_to
	end


	private

		def user_from_remember_token
			puts " user_from_remember_token "
			User.authenticate_with_salt(*remember_token)
		end

		def remember_token
			puts " remember_token "
			cookies.signed[:remember_token] || [nil, nil]
		end

		def store_location
			puts " store_location "
			session[:return_to] = request.fullpath
		end

		def clear_return_to
			puts " clear_return_to "
			session[:return_to] = nil
		end
end