class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  ## CONSTANTS ---------------------------------------------------------
  
  # Maximum number of records to display for #index views using the paginate function.
  PAGE_COUNT = 20
  
end
