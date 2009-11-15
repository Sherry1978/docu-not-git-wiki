require "sinatra/base"
require "haml"
require "sass"
require "grit"
require "rdiscount"

require "git_wiki/page_not_found"
require "git_wiki/page"
require "git_wiki/app"

module GitWiki
  class << self
    attr_accessor :homepage, :extension, :repository
  end

  def self.new(repository, extension, homepage)
    self.homepage   = homepage
    self.extension  = extension
    self.repository = Grit::Repo.new(repository)

    App
  end
end
