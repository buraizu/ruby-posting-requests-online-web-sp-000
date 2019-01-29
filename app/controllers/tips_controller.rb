class TipsController < ApplicationController

  def create
    resp = Faraday.post("https://api.foursquare.com/v2/tips/add") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20190127'
      req.params['venue_id'] = params[:venue_id]
      req.params['text'] = params[:tip]
    end
    redirect_to tips_path
  end

  def index
    resp = Faraday.get("https://api.foursquare.com/v2/lists/self/tips") do |req|
      req.params['oauth_token'] = session[:token]
      req.params['v'] = '20190127'
    end
    @results = JSON.parse(resp.body)["response"]["list"]["listItems"]["items"]
  end

end

# Use this syntax when API wants POST request in JSON format
# Faraday.post("https://url/to/api") do |req|
#   req.body = "{ "my_param": my_value }"
# end
