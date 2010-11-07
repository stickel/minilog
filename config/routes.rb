ActionController::Routing::Routes.draw do |map|
  tokens = /archives|past|posts|notes|older/
  # index
  # map.home '', :controller => 'application', :action => 'home'
  map.home '', :controller => 'posts', :action => 'home'
  
  # archives short URL
  map.posts_short '/p/:short_url_code', :controller => 'posts', :action => 'short_url'
  
  # archives by author
  map.posts_authors ':archive_token/authors/:id', :controller => 'posts', :action => 'by_author',
                    :archive_token => tokens
  
  # archives by day
  map.posts_day ':archive_token/:year/:month/:day', :controller => 'posts', :action => 'by_day',
                    :year => /\d{4}/, :month => /\d{2}/, :day => /\d{1,2}/, :archive_token => tokens
  
  # archives by month
  map.posts_month ':archive_token/:year/:month', :controller => 'posts', :action => 'by_month',
                    :year => /\d{4}/, :month => /\d{2}/, :archive_token => tokens
  
  # archives by year
  map.posts_year ':archive_token/:year', :controller => 'posts', :action => 'by_year',
                    :year => /\d{4}/, :archive_token => tokens
  
  # archive
  map.posts ':archive_token', :controller => 'posts', :action => 'archive', :archive_token => tokens
  map.posts_paged ':archive_token/page/:offset', :controller => 'posts', :action => 'archive', :archive_token => tokens
  
  # permalink
  map.post ':archive_token/:permalink', :controller => 'posts', :action => 'show',
                    :archive_token => tokens
  
  # tags
  map.tags 'tagged/:tag', :controller => 'tags', :action => 'list'
  
  # comments
  map.connect 'comments/add', :controller => 'posts', :action => 'add_comment'
  
  # feeds
  map.feeds 'feeds', :controller => 'feeds', :action => 'index'
  map.feed 'feeds/:feed', :controller => 'feeds', :action => 'show'
  
  # authentication
  map.logout '/signout', :controller => 'sessions', :action => 'destroy'
  map.login '/signin', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'people', :action => 'create'
  map.signup '/signup', :controller => 'people', :action => 'new'
  map.resources :people, :member => { :suspend => :put, :unsuspend => :put, :purge => :delete }
  map.resource :session
  
  # admin
  map.namespace(:admin) do |admin|
    admin.home '', :controller => 'base', :action => 'index'
    admin.preferences 'preferences', :controller => 'preferences', :action => 'index'
    admin.resources :posts
    admin.resources :pages
    admin.resources :people, :as => 'authors'
  end
  
  # "pages"
  map.pages ':permalink', :controller => 'pages', :action => 'show'
  
  # default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
