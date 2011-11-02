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
  	@attr = { name: "example", email: "ex@mail.com"}
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
 
end
