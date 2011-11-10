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

require 'spec_helper'

describe User do
  
  before :each do 
  	@attr = { 
	  	name: "example", 
	  	email: "ex@mail.com",
	    password: "qwertyqw",
	    password_confirmation: "qwertyqw"
	}
  end

  it 'should create user with valid attricutes' do
  	User.create!(@attr)
  end

  it 'should reject user with empty name' do
  	user = User.new(@attr.merge(name: ""))
  	user.should_not be_valid
  end

  it 'should not create user with empty email' do
  	no_email_user=User.new(@attr.merge(email: ""))
  	no_email_user.should_not be_valid
  end

  it 'should not create user with too long name' do
  	long_name = 'r'*31
  	user = User.new(@attr.merge(name: long_name))
  	user.should_not be_valid
  end

  it "should create user with email" do
  	addresess= %w[foo@mail.com  BASAD_USER@srg.org eg.srg@foo.lasd]
  	addresess.each do |adr|
  		valid_email_user = User.new(@attr.merge(email: adr))
  		valid_email_user.should be_valid
    end
  end

  it "should not create user with invalid email" do
  	addresess= %w[foo@mail,com  BASAD_USERsrg.org eg.srg@foo.lasd.]
  	addresess.each do |adr|
  		valid_email_user = User.new(@attr.merge(email: adr))
  		valid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe 'password' do

  	it 'should match password_confirmation' do
  		user = User.new(@attr.merge(password_confirmation: "snsfgjryn"))
  		user.should_not be_valid
    end

    it 'should reject user with short password' do
    	user = User.new(@attr.merge(password: "qazxswe",password_confirmation: "qazxswe"))
  		user.should_not be_valid
    end

    it 'should reject user with long password' do
        long = 'a'*51
    	user = User.new(@attr.merge(password: long, password_confirmation: long))
    	user.should_not be_valid
    end
  end

  describe 'encrypted password' do

  	before :each do
  		@user =User.create!(@attr)
    end
   
    it 'should respond to encrypted_password' do
    	@user.should respond_to(:encrypted_password)
    end

    it 'should set the encrypted_passowrd' do
    	@user.encrypted_password.should_not be_blank
    end

     describe 'has_password_method' do

        it 'should return true if password match' do
        	@user.has_password?(@attr[:password]).should be_true
        end

        it 'should return false if password does not match' do
        	@user.has_password?('invalid').should be_false
        end
     end

     describe 'authenticate method' do

     	it 'should return nil if no user with such email' do
     		wrong_user = User.authenticate('someemail@com.ru', @attr[:password])
     		wrong_user.should be_nil
     	end

     	it 'should return nil if no user with such password' do
     		wrong_user = User.authenticate(@attr[:email], '123321123')
     		wrong_user.should be_nil
     	end

     	it 'should return user' do
     		user = User.authenticate(@attr[:email], @attr[:password])
     		user.should == @user
     	end
     end


  end

 


 
end
