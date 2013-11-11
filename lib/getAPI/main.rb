require "./lib/getAPI/post_image_face.rb"
#require "./lib/getAPI/my_nokogiri.rb"

key = 'RCGHACKA13'
imageURL = "http://hajipion.com/images/akiho.jpg"

post = PostImageFace.new()
p Crack::XML.parse(post.post_image_url(key, imageURL, false))

#mydoc = MyDocument.new
#parser = Nokogiri::XML::SAX::Parser.new(mydoc)
#p parser.parse(post.post_image_url(key, imageURL, false))

