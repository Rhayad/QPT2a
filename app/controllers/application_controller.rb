class ApplicationController < ActionController::Base
  #csrf protection
  protect_from_forgery
  
  # helper for helpers/sessions_helper.rb
  include SessionsHelper


	helper :all

  	layout :detect_browser

  	private

  	# pattern match array of mobile user agents
  	MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]

  	def detect_browser
    	agent = request.headers["HTTP_USER_AGENT"].downcase
    	MOBILE_BROWSERS.each do |m|
      		return "mobile/mobile_application" if agent.match(m)
    	end
    	return "application"
  	end
end
