module GitWiki
  class App < Sinatra::Base
    set :app_file, __FILE__
    set :haml, { :format        => :html5,
                 :attr_wrapper  => '"'     }
    attr_accessor :page_class, :title

    error PageNotFound do
      page = request.env["sinatra.error"].name
      redirect "/#{page}/edit"
    end

    before do
      content_type "text/html", :charset => "utf-8"
      @page_class = [];
    end

    get '/application.css' do
      content_type "text/css; charset=utf-8", :charset => "utf-8"
      sass :"application"
    end

    get "/" do
      redirect "/" + GitWiki.homepage
    end

    get "/pages" do
      @pages = Page.find_all
      @page_class << 'pages'
      @title = "All Pages"
      haml :list
    end

    get "/:page/edit" do
      @page = Page.find_or_create(params[:page])
      @page_class << 'edit'
      @title = "Editing \"#{@page.name}\""
      haml :edit
    end

    get "/:page" do
      @page = Page.find(params[:page])
      @title = @page.name
      haml :show
    end

    post "/:page" do
      @page = Page.find_or_create(params[:page])
      @page.update_content(params[:body])
      redirect "/#{@page}"
    end

    private
      def title(title=nil)
        @title = title.to_s unless title.nil?
        @title
      end

      def list_item(page)
        %Q{<a class="page_name" href="/#{page}">#{page.name}</a>}
      end
  end
end