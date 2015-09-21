# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://seacoastpc-bubblewrap.rhcloud.com/"

SitemapGenerator::Sitemap.create do
  routes = Rails.application.routes.routes.map do |route|
    {alias: route.name, path: route.path.spec.to_s, controller: route.defaults[:controller], action: route.defaults[:action]}
  end

	banned_controllers = ["rails/info", nil]
	routes.reject! {|route| banned_controllers.include?(route[:controller])}
	routes.reject! {|route| route[:path] == '/'}
	routes.each {|route| add route[:path][0..-11]}


	# Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
