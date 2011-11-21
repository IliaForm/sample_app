require 'spec_helper'

describe UsersController do
  render_views
  
  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end

    it 'should have right title' do
      get 'new'
      response.should have_selector("title", :content => "Sign up")
    end
  end

  describe "GET show" do

  	before :each do
  		@user = Factory(:user)
  	end

  	it 'should be success' do
  		get :show, :id => @user.id
  		response.should be_success
  	end

  	it 'should return our user' do
  		get :show, :id => @user.id
  		assigns(:user).should == @user
  	end

  	it "should have the right title" do
      get :show, :id => @user
      response.should have_selector("title", :content => @user.name)
    end

    it "should include the user's name" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
    end

    it "should have a profile image" do
      get :show, :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end
  end

  describe 'POST create' do

  	describe 'fail' do

  	before :each do
  		@attr ={name: '', email: '', password: '', password_confirmation: ''}
    end

    it 'should not change count Users' do
    	lambda do
    		post :create, :user => @attr
    	end.should_not change(User, :count)
    end

    it 'should render new' do
    	post :create, :user => @attr
    	response.should render_template('users/new')
    end

    it 'should have title' do
    	post :create, :user => @attr
    	response.should have_selector("title", :content => "Sign up")
    end
    end

    describe 'success' do

    	before :each do
  		  @attr ={name: 'example user', email: 'example@mail.con', 
	  		    password: '12345678', password_confirmation: '12345678'}
        end
        
        it 'should ctore user' do
         lambda do
    	  	post :create, :user => @attr
    	 end.should change(User, :count).by(1)
        end

    	it 'should redirect users page' do
    		post :create, :user => @attr
    		response.should redirect_to(user_path(assigns(:user)))
    	end

    	it 'should have right flash' do
    		post :create, :user => @attr
    		flash[:success].should =~/welcome to the sample app/i
        end
    end
  end
end
