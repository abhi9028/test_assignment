class ProductsController < ApplicationController
 
  # get list of products
  def index
    @products = Product.paginate(page: params[:page], per_page: 9).order('created_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  	@product = Product.find(params[:id])
  end
end