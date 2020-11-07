class PagesController < ApplicationController

	def home
	 redirect_to pictures_path if logged_in?
	end
	
end