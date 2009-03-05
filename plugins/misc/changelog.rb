Wiki::Plugin.define 'misc/changelog' do
  require 'rss/maker'

  Wiki::App.class_eval do
    get '/changelog.rss', '/:path/changelog.rss' do
      object = Wiki::Object.find!(@repo, params[:path])
      cache_control :etag => object.latest_commit.sha, :last_modified => object.latest_commit.committer_date

      content_type 'application/rss+xml', :charset => 'utf-8'
      content = RSS::Maker.make('2.0') do |rss|
        rss.channel.title = Wiki::Config.title
        rss.channel.link = request.scheme + '://' +  (request.host + ':' + request.port.to_s)
        rss.channel.description = Wiki::Config.title + ' Changelog'
        rss.items.do_sort = true
        object.history.each do |commit|
          i = rss.items.new_item
          i.title = commit.message
          i.link = request.scheme + '://' + (request.host + ':' + request.port.to_s)/object.path/commit.sha
          i.date = commit.committer.date
        end
      end
      content.to_s
    end
  end

end