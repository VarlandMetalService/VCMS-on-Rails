class CategoriesController < ApplicationController

  before_action :check_permission

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to documents_url, notice: "Successfully added <code>#{@category.name}</code>.".html_safe
    else
      redirect_to documents_url, flash: { error: "Error adding <code>#{@category.name}</code>. Please try again or contact IT for help.".html_safe }
    end
  end

private

  def check_permission
    require_permission 'documents', 3
  end

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

end