require 'open-uri'
class EmbedsController < ApplicationController
  def show
    url = params[:url]
    return head(404) unless url =~ /^http.?:\/\//
    hash = Digest::MD5.hexdigest(url)
    @url = Url.where(:url_hash => hash).first
    unless @url
      text = open(url).read
      @url = Url.create(:url_hash => hash, :url => url, :body => text)
    end
    response.headers['Content-Type'] = 'application/json; charset=utf-8' if @url.url =~ /.*\.json($|\?)/
    if @url.url =~ /^http.?:\/\/gist\.github\.com\//
      @wrap = true
    end
    return render :layout => false
  end
end
