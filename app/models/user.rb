# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	attr_accessor :password

	attr_accessible :name, :email, :password, :password_confirmation

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence => true, :length => { :maximum => 50}
	validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }

	#validates :password, :presence => true, :confirmation => true, :length => {:within => 6..40} 
	validates :password, :confirmation => true

	before_save :encrypt_password

	def has_password?(submitted_password)
		puts "  has_password #{encrypted_password}?"
		encrypted_password == encrypt(submitted_password)
	end

	def self.authenticate(email, submitted_password)
		puts " self.authenticate #{email} #{submitted_password}"
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end

	def self.authenticate_with_salt(id, cookie_salt)
		puts " self.authenticate_with_salt "
		puts "id = #{id} and cookie_salt = #{cookie_salt}"
		user = find_by_id(id)
		if user
			puts "usr.salt =#{user.salt}"
			puts "user.salt == cookie_salt = #{user.salt == cookie_salt}"
		end
		(user && user.salt == cookie_salt) ? user : nil
	end

	private

		def encrypt_password
			puts " encrypt_password "
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			puts " encrypt "
			secure_hash("#{salt}--#{string}")
		end

		def make_salt
			puts " make_salt "
			secure_hash("#{Time.now.utc}--#{password}")
		end

		def secure_hash(string)
			puts " secure_hash "
			Digest::SHA2.hexdigest(string)
		end
end












