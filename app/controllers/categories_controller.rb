class CategoriesController < ApplicationController

    def show
        @category = Category.find(params[:id])
    end
 
    def index
        @categories = Category.paginate(page: params[:page], per_page: 3)
    end
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "You successfully created a new category!"
            redirect_to categories_path
        else
            render 'new'
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

end