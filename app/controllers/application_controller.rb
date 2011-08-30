class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
    def current_cart
      Cart.find(session[:cart_id])
    rescue
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
    
    def increment_visit_count
      session[:counter] ||= 0
      session[:counter] += 1
    end
    
    def reset_visit_count
      session.delete(:counter)
    end
    
end
