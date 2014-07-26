
class FeedCreator

  def parse_file(file, current_user) #must pass current_user from view or controller for devise helper method to work
    f = File.open(file)
    doc = Nokogiri::XML(f)
    doc.xpath("//outline").each do |x|
      unless x['xmlUrl']==nil
      feed = Feed.new
      feed.url = x['xmlUrl']
      feed.name = x['title']
      feed.user_id = current_user.user_id
      feed.feedly_feed_id = "feed/#{x['xmlUrl']}"
    end
  end

end