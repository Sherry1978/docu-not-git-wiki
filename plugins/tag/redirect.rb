depends_on 'filter/tag'

class Wiki::App
  add_hook(:before_content) do
    @resource && params[:redirect] ? "<em>&#8594; Redirected from <a href=\"#{action_path(params[:redirect], :edit)}\">#{params[:redirect].cleanpath}</a></em>" : nil
  end
end

Tag.define(:redirect, :requires => :href) do |context, attrs, content|
  path = resource_path(context.page, :path => attrs['href'], :redirect => context.page.path)
  if path == resource_path(context.page)
    "Invalid redirect to #{path}"
  elsif context.page.modified?
    "Redirect to #{path}"
  else
    throw :redirect, path
  end
end
