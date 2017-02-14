module ApplicationHelper
	def title
		unless @title.nil?
		   "Ruby on Rails Tutorial Sample App | #{@title}" 
		else
		   "Ruby on Rails Tutorial Sample App"
		end
	end

	def logo
	image_tag("logo.png", :alt => "Sample App", :class => "round")
	end
end
