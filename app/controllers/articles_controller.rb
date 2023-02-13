class ArticlesController < ApplicationController

    before_action :find_article, only:[:show, :edit, :update, :destroy] 


    def show
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 3)
    end

    def new 
        @article = Article.new 
    end

    def edit
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article is created successfully"
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article is updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    # "private" should be always placed at the bottom of your syntax as anything under it will be accessible only here 
    private

    def find_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

end