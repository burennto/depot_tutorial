class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_i18n_locale_from_params
  before_filter :authorize
  
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
  
  protected
  
    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
    
    def default_url_options
      { :locale => I18n.locale }
    end
  
    def authorize
      unless User.find_by_id(session[:user_id])
        redirect_to login_url, :notice => "Please log in"
      end
    end
end
