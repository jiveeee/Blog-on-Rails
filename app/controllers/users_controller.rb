class UsersController < ApplicationController
    #we already have created & migrated users table, added & migrated password_digest column to it.

    before_action :find_user, only:[:edit, :update]

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your profile is successfully updated"
            redirect_to articles_path
        else
            render 'edit'
        end
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

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end