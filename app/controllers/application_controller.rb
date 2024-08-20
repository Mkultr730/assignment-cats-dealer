class ApplicationController < ActionController::Base
  include ErrorHandler
  protect_from_forgery with: :exception
end
