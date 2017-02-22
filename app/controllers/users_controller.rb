class UsersController < ApplicationController
	before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user, :only => :destroy
	def new
		@title = "sign up"
		@user = User.new
	end

	def show
		@user = User.find(params[:id])
		if current_user == @user || current_user.privilege
			@title = @user.name
		else
			flash[:error] = "Not Privileged User!"
			redirect_to(root_path)
		end 	
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			Resque.enqueue(Sleeper, 15)			
			sign_in @user
			flash[:success] = "sign up done!, Welcome to the Sample App!"
			redirect_to @user
		else	
			flash[:success] = "sign up failed"
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
		puts "current_user ===#{current_user.privilege}"
		if current_user.privilege
			@users = User.paginate(:page => params[:page])
			@title = "All Users"
		else
			flash[:error] = "Not Privileged User!"
			redirect_to(root_path)
		end 
		
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end


	def providePrivilege
		if current_user.admin
			puts "camess   ====== #{params[:id]}....#{params[:status]}"
			User.updatePrivilege(params[:id],params[:status])
			redirect_to users_path
		else

			flash[:error] = "dont have rights!"
			redirect_to(root_path)
		end
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
