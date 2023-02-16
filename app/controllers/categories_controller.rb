class CategoriesController < ApplicationController

    def show
    end
 
    def index
    end
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "You successfully created a new category!"
            redirect_to @category
        else
            render 'new'
        end
    end

    private

    def category_params
        params.require(:category).permit(:name)
    end

end