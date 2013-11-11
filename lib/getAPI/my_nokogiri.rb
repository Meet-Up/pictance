class MyNokogiri < Nokogiri::XML::SAX::Document
	attr_reader :results

	def initialize
		@stack = []
		@result = {}
		@results = []
		@param_key = nil
    	super
  	end

  	def start_document
  	end

  	def start_element(name, attributes = [])
    	@stack << name

    	if name == "param"
      		@param_key = attributes[0][1]
      		@result["ggg"]["hhh"][@param_key] = ""
    	elsif name == "name" || name == "val"
    	elsif name == "content"
      		# new object
      		@result = {}
    	elsif name == "ggg"
      		@result["ggg"] = { attributes[0][0] => attributes[0][1] }
    	elsif name == "hhh"
      		@result["ggg"]["hhh"] = {
        		attributes[0][0] => attributes[0][1],
        		attributes[1][0] => attributes[1][1],
      		}
    	elsif /^aaa|bbb|ccc|ddd|eee|fff$/ === name
      		@result[name] = ""
    	end
  	end

  	def characters(string)
    	element = @stack.last

    	if element == "val"
      		@result["ggg"]["hhh"][@param_key] += string
    	elsif /^aaa|bbb|ccc|ddd|eee|fff$/ === element
      		@result[element] += string
    	end
  	end

  	def end_element(name, attributes = [])
    	if name == "content"
      		@results << @result
    	end
  	end

  	def end_document
  	end
end

#mydoc = MyDocument.new
#parser = Nokogiri::XML::SAX::Parser.new(mydoc)
#parser.parse(XML)
