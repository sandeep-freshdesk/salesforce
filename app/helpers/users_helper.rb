module UsersHelper

	def gravatar_for(user, options = { :size => 50 })
		gravatar_image_tag(user.email.downcase, :alt => user.name,
		:class => 'gravatar',
		:gravatar => options)
	end

	def facebookUserInfo(token)
	    puts "tok = #{token}"
	    facebook = Koala::Facebook::API.new(token)
	    puts "fab obj = #{facebook}"
	    fbObj = facebook.get_object("me?fields=name,picture")
	    #friends = facebook.get_connections('me', "friends")
	    #puts "fbObj = #{fbObj}"
	    fbObj['picture']['data']['url']
	end

end
