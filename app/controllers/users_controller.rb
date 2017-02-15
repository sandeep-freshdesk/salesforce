class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	def new
		@title = "sign up"
		@user = User.new
	end

	def show

		puts "user ctrl sdfdf= #{cookies.signed[:remember_token]}"

		if cookies.signed[:remember_token] &&  cookies.signed[:remember_token][0] &&  ((cookies.signed[:remember_token][0]).is_a? Integer)
			puts "in if "	
			@user = User.find(params[:id])
			@title = @user.name
		elsif cookies.signed[:remember_token] &&  cookies.signed[:remember_token][1] && ((cookies.signed[:remember_token][1]).is_a? Integer)
			puts "eeelsiiiifffff"
			@user = Authuser.find(params[:id])
		end
			
		 
		
	end

	def create
		@user = User.new(params[:user])
		if @user.save
		sign_in @user
		flash[:success] = "Welcome to the Sample App!"
		redirect_to @user
		else
		@title = "Sign up"
		render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
		@title = "Edit user"
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
		flash[:success] = "Profile updated."
		redirect_to @user
		else
		@title = "Edit user"
		render 'edit'
		end
	end

	def index
		@users = User.paginate(:page => params[:page])
		@title = "All Users"
		
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end

	private 
		def user_params
			params(:user).permit(:name, :email, :password, :password_confirmation)
		end

		def authenticate
			deny_access unless signed_in?
		end

		def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
			end
end
