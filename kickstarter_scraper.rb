# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  # projects: kickstarter.css("li.project.grid_4")
  # title: project.css("h2.bbcard_name strong a").text
  # img: project.css('.project-thumbnail a img').attribute('src').value
  #desc: project.css('p.bbcard_blurb').text.strip
  # location : project.css('a span.location-name').text.strip
  # percent : project.css('ul.project-stats li.first.funded strong').text.gsub("%", "").to_i
  projects = {}

  kickstarter.css('li.project.grid_4').each do |project|
    symbol = project.css("h2.bbcard_name strong a").text
    projects[symbol.to_sym] = {
      image_link: project.css('.project-thumbnail a img').attribute('src').value,
      description: project.css('p.bbcard_blurb').text.strip,
      location: project.css('a span.location-name').text.strip,
      percent_funded: project.css('ul.project-stats li.first.funded strong').text.gsub("%", "").to_i,
    }

  end
  projects
end

 p create_project_hash[:'AT HOME']
