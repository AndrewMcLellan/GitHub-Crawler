# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'nokogiri'
require 'open-uri'
require 'pry'

TRENDING_URL = 'https://github.com/trending?since=weekly'
page = Nokogiri::HTML(open(TRENDING_URL))

# fetch all of the HTML `<li>` elements that represent individual repositories
repo_list_items = page.css(".repo-list li")
item_number = 1
language_id = 1
language_array = []
language_stock_array = []

repo_list_items.each do |item|
  if item.css("div")[3].css("span")[0].children[3].text? != true &&
    !language_stock_array.include?(item.css("div")[3].css("span")[0].children[3].text.strip)
    repo_info = {
      name: item.css("div")[3].css("span")[0].children[3].text.strip,
      language_id: language_id
    }
    if !language_stock_array.include?(item.css("div")[3].css("span")[0].children[3].text.strip)
      language = item.css("div")[3].css("span")[0].children[3].text.strip
      language_stock_array << language
    end
    language_array << repo_info
    language_id += 1
  end
end

all_contributors_array = []
post_array = []
post_id= 1

repo_list_items.each do |item|
  contributor_array = []
  real_language_id = nil
  puts "Item number " + item_number.to_s

  print ("written primarily in: ")
  #the boolean value of the the following line was not what i expected.
  #this line returns true when this is NO text specifing a language
  if item.css("div")[3].css("span")[0].children[3].text? == true
    repo_info = {
      name: item.css("div")[0].children[1].css("a")[0].text.strip,
      description: item.css("div")[2].children[1].text.strip,
      language_id: nil
    }
    post_array << repo_info
  else
    language_index = 0
    language_array.each do |language|
      if language[:name] == item.css("div")[3].css("span")[0].children[3].text.strip
        real_language_id = language_array[language_index][:language_id]
      end
      language_index += 1
    end

    repo_info = {
      name: item.css("div")[0].children[1].css("a")[0].text.strip,
      description: item.css("div")[2].children[1].text.strip,
      language_id: real_language_id
    }
    post_array << repo_info
  end


  # binding.pry
  #this line handles the case where there is no language. the structure
  #of the returned data is defferent when a repo does't specify a launguage,
  #so we have to account for that when we filter through the data
  if item.css("div")[3].css("span")[0].children[3].text? == true
      contributor = {name: item.css("div")[3].css("span")[0].css("img")[0].values.last}
      contributor_array << contributor
    #i found there was a case later on that has only one contrubutor, so this
    #handles cases when the there IS a second contributor AND the repo does not
    #specify a language
    if item.css("div")[3].css("span")[0].css("img")[1].values.last != nil

      second_contributor = item.css("div")[3].css("span")[0].css("img")[1].values.last
      contributor = {name: second_contributor}
      contributor_array << contributor
    end
  else
     contributor = {name: item.css("div")[3].css("span")[3].css("img")[0].values.last}
     contributor_array << contributor
     if item.css("div")[3].css("span")[3].css("img")[1] != nil
       contributor = {name: item.css("div")[3].css("span")[3].css("img")[1].values.last}
       contributor_array << contributor
     end
  end
  all_contributors_array << contributor_array
  puts "----------------------------------"
  item_number += 1
  post_id += 1
end


language_array.each do |language|
  Language.create!({name: language[:name]})
end

post_array.each do |post|
  Post.create!(post)
end
