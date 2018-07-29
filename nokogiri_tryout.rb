require 'nokogiri'
require 'open-uri'
require 'pry'

TRENDING_URL = 'https://github.com/trending?since=weekly'
page = Nokogiri::HTML(open(TRENDING_URL))

# fetch all of the HTML `<li>` elements that represent individual repositories
repo_list_items = page.css(".repo-list li")




item_number = 1
div_index = 0
repo_list_items.each do |item|
  puts "Item number " + item_number.to_s
  puts (item.css("div")[0].children[1].css("a")[0].text.strip)
  puts ("=================================")
  puts (item.css("div")[2].children[1].text.strip)
  # "========getting language======="
  print ("written primarily in: ")
  if item.css("div")[3].css("span")[0].children[3].text? == true
    puts ("N/A")
  else
    puts (item.css("div")[3].css("span")[0].children[3].text.strip)
  end
  puts("primary Contributors: ")
  # binding.pry
  if item.css("div")[3].css("span")[0].children[3].text? == true
    puts item.css("div")[3].css("span")[0].css("img")[0].values.last
    if puts item.css("div")[3].css("span")[0].css("img")[1].values.last != nil
      puts item.css("div")[3].css("span")[0].css("img")[1].values.last
    end
  else
     puts item.css("div")[3].css("span")[3].css("img")[0].values.last
     if item.css("div")[3].css("span")[3].css("img")[1] != nil
       puts item.css("div")[3].css("span")[3].css("img")[1].values.last
     end
      # puts ("is this working")

  end
  # puts (item.css("div")[3])

  puts "----------------------------------"
  item_number += 1
end

# item_number = 1
# div_index = 0
# array_num = 1
# repo_array = []
# repo_list_items.each do |item|
#   array = Array.new
#   puts "Item number " + item_number.to_s
#   # puts ("========title=======")
#   title_of_repo = item.css("div")[0].children[1].css("a")[0].text.strip
#   array << title_of_repo
#   # puts ("========description=======")
#   description = item.css("div")[2].children[1].text.strip
#   array << description
#   # binding.pry
#   # "========getting language======="
#   print ("written primarily in: ")
#   #the boolean value of the the following line was not what i expected.
#   #this line returns true when this is NO text specifing a language
#   if item.css("div")[3].css("span")[0].children[3].text? == true
#     puts ("N/A")
#   else
#     language = item.css("div")[3].css("span")[0].children[3].text.strip
#     array << language
#
#   end
#   puts("primary Contributors: ")
#   # binding.pry
#   #this line handles the case where there is no language. the structure
#   #of the returned data is defferent when a repo does't specify a launguage,
#   #so we have to account for that when we filter through the data
#   contributors = []
#   if item.css("div")[3].css("span")[0].children[3].text? == true
#     first_contributor = item.css("div")[3].css("span")[0].css("img")[0].values.last
#     contributors << first_contributor
#     #i found there was a case later on that has only one contrubutor, so this
#     #handles cases when the there IS a second contributor AND the repo does not
#     #specify a language
#     if item.css("div")[3].css("span")[0].css("img")[1].values.last != nil
#
#       second_contributor = item.css("div")[3].css("span")[0].css("img")[1].values.last
#       contributors << second_contributor
#     end
#   else
#      first_contributor = item.css("div")[3].css("span")[3].css("img")[0].values.last
#      contributors << first_contributor
#      if item.css("div")[3].css("span")[3].css("img")[1] != nil
#        second_contributor = item.css("div")[3].css("span")[3].css("img")[1].values.last
#        contributors << second_contributor
#      end
#       # puts ("is this working")
#   end
#   array << contributors
#   repo_array << array
#   # puts (item.css("div")[3])
#   puts "----------------------------------"
#   item_number += 1
# end
# binding.pry
