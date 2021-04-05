class SessionsController < ApplicationController

    def new
        @user = User.new
       render :new 
    end


    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

        if @user
            login!(@user)
            redirect_to cats_url
        else
            render :new
        end
    end

    #requires information from user
    #session starts w user info// cookies
    #has access to things to call on the class

end