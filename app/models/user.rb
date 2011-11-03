# == Schema Information
#
# Table name: users
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
    attr_accessor :password

	attr_accessible :name, :email, :password, :password_confirmation

    email_regexp = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :name, :presence => true,
                     :length => {:maximum => 30}

	validates :email, :presence => true,
	                  :format   => { :with => email_regexp },
	                  :uniqueness => {:case_sensitive => false}

	validates :password, :presence => true,
					     :confirmation => true,
					     :length => { :within => 8..50} 
	
	before_save :encrypt_password

	def has_password?(submitted_password)
	end
	
private

    def encrypt_password
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
       string
    end

	                  
end
