require 'httparty'
require 'json'

def fetch_repositories(username)
  url = "https://api.github.com/users/#{username}/repos"
  response = HTTParty.get(url)
  if response.code == 200
    JSON.parse(response.body)
  else
    puts "Error fetching repositories: #{response.code}"
    exit
  end
end

def find_most_starred_repository(repositories)
  repositories.max_by { |repo| repo['stargazers_count'] }
end

def display_most_starred_repository(repository)
  puts "Name: #{repository['name']}"
  puts "Description: #{repository['description']}"
  puts "Stars: #{repository['stargazers_count']}"
  puts "URL: #{repository['html_url']}"
end

def main(username)
  repositories = fetch_repositories(username)
  most_starred = find_most_starred_repository(repositories)
  display_most_starred_repository(most_starred)
end

main('amai917')

