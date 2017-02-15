module UsersHelper

	def gravatar_for(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => user.name,
		:class => 'gravatar',
		:gravatar => options)
	end

	 def current_user_class(user)
		user.class == User #compare class of user with User model
	end
end
