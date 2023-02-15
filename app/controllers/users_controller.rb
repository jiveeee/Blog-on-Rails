class UsersController < ApplicationController
    #we already have created & migrated users table, added & migrated password_digest column to it.

    before_action :find_user, only:[:edit, :update, :show, :destroy]
    before_action :require_user, except:[:show, :index]
    before_action :require_same_user, only:[:edit, :update, :destroy]

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 2)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 3)
    end

    def new
        @user = User.new
    end

    def edit
    end

    def update
        if @user.update(user_params)
            flash[:notice] = "Your profile is successfully updated"
            redirect_to user_path
        else
            render 'edit'
        end
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "Welcome to the Blog on Rails #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Account and all associated articles are deleted"
        redirect_to articles_path
    end

    private

    def find_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only modify your own profile"
            redirect_to user_path
        end
    end

end