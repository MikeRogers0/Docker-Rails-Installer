require "open-uri"

base_uri = "https://raw.githubusercontent.com/Ruby-Starter-Kits/Docker-Rails-Generator/master/App-Template/"

files = [
  ".github/workflows/tests.yml",
  "bin/docker/entrypoints/wait-for-postgres.sh",
  "bin/docker/entrypoints/wait-for-web.sh",
  "bin/docker/prepare-to-start-rails",
  "config/cable.yml",
  "config/database.yml",
  ".dockerignore",
  "docker-compose.ci.yml",
  "docker-compose.yml",
  "Dockerfile"
]

files.each do |file_path|
  file file_path, URI.parse("#{base_uri}#{file_path}").open.read
end

if yes?("Build Docker Environment?")
  run("docker-compose build && docker-compose run --rm web bin/setup")

  if yes?("Start Your Ruby on Rails App?")
    run("docker-compose up")
  else
    run("docker-compose down")
  end
end
