#add text to homepage
#add header image
#add button labels
#add buttons to home
#make results hyperlinks
#redirect from search to getdesc
#
#add results page for each query via redirect
#clear sample URLs in posts



require 'sinatra'
require 'open-uri'
require 'csv'
require 'bundler'

APP_ROOT = File.dirname(__FILE__)


$exclude = []
$urls = []
$add_em = []
$links = []
$matches = []
$user_url = []
$url_thumbnail = []

class App < Sinatra::Base
 
#download or display file?

get "/" do
  erb :home
end

get "/nominate" do    
    erb :nominate
  end

  post "/nominate" do
    $user_url << params[:noms].values[0].to_s
    p $user_url
    redirect "/nominate"
  end

get '/thanks' do
  erb :thanks
end
  
  post '/submiturl' do
    redirect '/thanks'
  end



  get '/holder' do
    erb :holder
  end

  
get '/getlinks' do
    erb :link_results
end

 post '/getlinks' do

        @this_page = params[:links].values[0].to_s
       
      def get_links(newpage)
    #Go to specified URL, scrape links/descriptions for new URLs
   #just use mechanize
      #exclude facebook pages

      # pages.each do |pg| 
      #  begin
       mech = Mechanize.new 
       page = mech.get(newpage)
        # # rescue Mechanize::ResponseCodeError => exception
        # #   if exception.response_code == '404'
        # rescue Mechanize::ResponseCodeError => e
        # #page = e.force_parse
        # puts e.to_s
        # #    #mechanize exits on errors
        # else 
          # page.links.each do |link|
          # $text_page << [link, link.text]
          # end #end page links
        #@links = page.links
        #end #end rescue
        page.links.each do |link| $links << "#{link.text}, #{link.href}"
        end
        #end #end pages each
        # end
      end #end get_links
    
    get_links(@this_page)
      redirect '/getlinks'
  end #end post /links

  #redirect '/link_results'
# end

get '/newsearch' do
  File.delete('public/image.png') if File.exist?('public/image.png')
  $user_url = []
  $links = []
  redirect '/'
end

  get '/link_results' do
    erb :link_results
  end


#archive pages
  get '/archive' do
    erb :archive
  end
end

