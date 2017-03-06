require 'open-uri'
require 'json'

module Instascrape
  def self.get_media(username)
    get_media_nodes(username).map do |node|
      node["images"]["standard_resolution"]["url"]
    end
  rescue OpenURI::HTTPError => e
    []
  end

  private

  def self.get_media_nodes(username)
    JSON.parse(open("https://www.instagram.com/#{username}/media/").read)["items"]
  end
end
