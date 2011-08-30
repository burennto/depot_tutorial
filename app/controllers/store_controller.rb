class StoreController < ApplicationController
  
  def index
    @products = Product.all
    @visits = increment_visit_count    
  end

end
