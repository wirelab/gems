require 'nokogiri'
require 'httparty'

module Favicon
  class Fetcher
    include HTTParty
    follow_redirects true
  end

  def self.get(url)
    uri = Addressable::URI.heuristic_parse(url)
    html = Fetcher.get(uri.to_s).body
    doc = Nokogiri::HTML html
    [
      favicons = parse_icons(doc),
      parse_shortcut_icons(doc),
      fallback_icon(uri)
    ].flatten.sort { |y, x| x[:x] <=> y[:x] }
  end

  def self.parse_icons(doc)
    doc.css('link[rel=icon]').map do |element|
      {
        href: element.attr('href'),
        x: element.attr('sizes').split('x')[0].to_i,
        y: element.attr('sizes').split('x')[1].to_i
      }
    end
  end

  def self.parse_shortcut_icons(doc)
    doc.css('link[rel="shortcut icon"]').map do |element|
      {
        href: element.attr('href'),
        x: 16,
        y: 16
      }
    end
  end
  
  def self.fallback_icon(uri)
    {
      href: uri.join('favicon.ico').to_s,
      x: 0,
      y: 0,
    }
  end
end
