class UsersController < ApplicationController
    #we already have created & migrated users table, added & migrated password_digest column to it.
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "Welcome to the Blog on Rails #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end