require 'rss'
require 'open-uri'

class FeedRss
  
  attr_reader :feed, :url

  def initialize(url)
    @url = url
  end

  def feed
    begin
      open(url) do |rss|
        feed = parse_rss(rss)
        title(feed)
        items(feed)
      end
    rescue
      puts 'failed link feed'
    end
  end
  
  def parse_rss(rss)
    RSS::Parser.parse(rss)
  end
  
  def title(feed)
    puts "Title: #{feed.channel.title}"
  end

  def items(feed)
    feed.items.first(10).each do |item|
      item_title(item)
      item_link(item)
      item_date(item)
      puts '--------------'
    end
  end

  def item_title(item)
    puts "Item: #{item.title}"
  end

  def item_link(item)
    puts "Link: #{item.link}"
  end

  def item_date(item)
    puts "Date: #{item.pubDate}"
  end
end


feed_rss = FeedRss.new('https://jovemnerd.com.br/feed-nerdcast/')

feed_rss.feed