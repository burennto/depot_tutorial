class StoreController < ApplicationController
  
  def index
    @products = Product.all
    @cart = current_cart
    @visits = increment_visit_count    
  end

end
