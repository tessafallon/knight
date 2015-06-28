require 'open-uri'
require 'nokogiri'
require 'metainspector'
require 'csv'

#interface should allow user to feed a list of URLs
#find new sites

doc = Nokogiri::HTML(open("http://www.google.com/search?num=100&q=%22Aimee+Tsao%22+bay+area+dance+-linkedin"))

found_pages = []

doc.css('cite').each do |cite|  
  found_pages << cite.text
end 

 def get_descriptions(urls)
    CSV.open("urls.csv", "wb")do |csv|
    csv << ["page title", "url", "description"]
    end
  
   add_em = []

   urls.each do |url|
   page = MetaInspector.new(url)
   add_em =[page.title,page.url,page.description]
    CSV.open("urls.csv", "a+")do |csv|
    csv << add_em
    end
  end
end

 #get_descriptions(found_pages)

 

def get_links(this_page)
  #output links to csv
  #existing sites; go to specified URL, crawl new URLs
  #example uses Nokogiri css selectors to find linkes on this specific page; this will only work with the example link

  doc = Nokogiri::HTML(open(this_page))
  links = doc.css('h2 a').map { |link| link['href'] }
  
  CSV.open("links.csv", "w")do |csv|
    links.each do |link|
      csv << [link]
    end
  end

end

#get_links("http://dancetabs.com/category/reviews-of-dance-and-ballet-performances/")


def get_text(text_page)
  #go to each link from get_links, scrape text; all text looks like just p?
  #open csv, each row, new csv, add columns
  doc = Nokogiri::HTML(open(text_page))
  text = doc.css('p').text
  keywords = ["pow wow", "Royal", "ballet",
"hula"  ,
"hip hop" ,
"two step"  ,
"waltz" ,
"polka" ,
"bharatanatyam" ,
"bharata natyam"  ,
"ballerina" ,
"jazz"  ,
"breakdancing"  ,
"salsa" ,
"meringue"  ,
"flamenco"  ,
"contradanse" ,
"contradanc*" ,
"western squares" ,
"ballroom"  ,
"capoeira"  ,
"danc*" ,
"go-go" ,
"pirouette" ,
"arabesque" ,
"kathak"  ,
"b-boying"  ,
"gangnum" ,
"tap" ,
"electric slide"  ,
"moonwalk"  ,
"tango" ,
"mambo" ,
"twist" ,
"charleston"  ,
"quickstep" ,
"jive"  ,
"bollywood" ,
"disco "  ,
"rave"  ,
"jookin"  ,
"locking" ,
"popping" ,
"pop and lock"  ,
"electric boogaloo" ,
"stepping",
"jig" ,
"clogging"  ,
"shim sham" ,
"foxtrot" ,
"butoh" ,
"tarantella"  ,
"swing" ,
"bhangra" ,
"kathakali" ,
"kuchipudhi"  ,
"Mohiniyattam"  ,
"Odissi"  ,
"Sattriya"  ,
"garba",
"Royal"]

  if keywords.any? { |w| text =~ /#{w}/ }
    matches = []
    keywords.each do |kywd| text.match(kywd) != nil ? matches << text.match(kywd) : "nothing"
  end
  p matches
  else
    puts "nope."
  end

end

get_text("http://dancetabs.com/2015/06/the-royal-ballet-the-dream-song-of-the-earth-new-york/")