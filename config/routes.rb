require 'noosfero'

ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  ######################################################
  ## Public controllers
  ######################################################

  map.connect 'test/:controller/:action/:id'  , :controller => /.*test.*/
 
  # -- just remember to delete public/index.html.
  # You can have the root of your site routed by hooking up ''
  map.connect '', :controller => "home", :conditions => { :if => lambda { |env| !Domain.hosting_profile_at(env[:host]) } }

  # user account controller
  map.connect 'account/new_password/:code', :controller => 'account', :action => 'new_password'
  map.connect 'account/:action', :controller => 'account'

  # enterprise registration
  map.connect 'enterprise_registration/:action', :controller => 'enterprise_registration'

  # tags
  map.tag 'tag', :controller => 'search', :action => 'tags'
  map.tag 'tag/:tag', :controller => 'search', :action => 'tag', :tag => /.*/
  
  # categories index
  map.category 'cat/*category_path', :controller => 'search', :action => 'category_index'
  map.assets 'assets/:asset/*category_path', :controller => 'search', :action => 'assets'
  map.directory 'directory/:asset/:initial/*category_path', :controller => 'search', :action => 'directory'
  # search
  map.connect 'search/:action/*category_path', :controller => 'search'
 

  # public profile information
  map.profile 'profile/:profile/:action/:id', :controller => 'profile', :action => 'index', :id => /.*/, :profile => /#{Noosfero.identifier_format}/

  # catalog
  map.catalog 'catalog/:profile', :controller => 'catalog', :action => 'index', :profile => /#{Noosfero.identifier_format}/
  map.product 'catalog/:profile/:id', :controller => 'catalog', :action => 'show', :profile => /#{Noosfero.identifier_format}/

  # contact
  map.contact 'contact/:profile/:action/:id', :controller => 'contact', :action => 'index', :id => /.*/, :profile => /#{Noosfero.identifier_format}/

  ######################################################
  ## Controllers that are profile-specific (for profile admins )
  ######################################################
  # profile customization - "My profile"
  map.myprofile 'myprofile/:profile', :controller => 'profile_editor', :action => 'index', :profile => /#{Noosfero.identifier_format}/
  map.myprofile 'myprofile/:profile/:controller/:action/:id', :controller => Noosfero.pattern_for_controllers_in_directory('my_profile'), :profile => /#{Noosfero.identifier_format}/


  ######################################################
  ## Controllers that are used by environment admin
  ######################################################
  # administrative tasks for a environment
  map.admin 'admin', :controller => 'admin_panel'
  map.admin 'admin/:controller/:action/:id', :controller => Noosfero.pattern_for_controllers_in_directory('admin')


  ######################################################
  ## Controllers that are used by system admin
  ######################################################
  # administrative tasks for a environment
  map.system 'system', :controller => 'system'
  map.system 'system/:controller/:action/:id', :controller => Noosfero.pattern_for_controllers_in_directory('system')

  # cache stuff - hack
  map.cache 'public/:action/:id', :controller => 'public'

  # match requests for content in domains hosted for profiles
  map.connect '*page', :controller => 'content_viewer', :action => 'view_page', :conditions => { :if => lambda { |env| Domain.hosting_profile_at(env[:host])} }

  # XXX this route must come last so other routes have priority over it.
  map.homepage ':profile/*page', :controller => 'content_viewer', :action => 'view_page', :profile => /#{Noosfero.identifier_format}/

end
