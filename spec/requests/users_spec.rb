require 'spec_helper'

describe "Users" do
  describe "signup" do
    describe "failure" do
      it "should not create user" do
        lambda do
         visit signup_path 
         fill_in 'Name',          :with => ''
         fill_in 'Email',         :with => ''
         fill_in 'Password',      :with => ''
         fill_in 'Confirmation',  :with => ''
         click_button
         response.should have_selector("div#error_explanation")
         response.should render_template('users/new')
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "name",         :with => "Example User"
          fill_in "email",        :with => "user@example.com"
          fill_in "password",     :with => "foobarqw"
          fill_in "Confirmation", :with => "foobarqw"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end
end
