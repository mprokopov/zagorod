ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.
  
  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # You can have the root of your site routed by hooking up '' 
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "home"

  # active tab - активная закладка
  map.connect 'about', :controller => 'page',  :url=>'about', :active_tab=>'3'
  map.connect 'partners', :controller => 'page',  :url=>'partners'
  map.connect 'services', :controller => 'services'
  map.connect 'useful', :controller => 'page',  :url=>'useful', :active_tab=>'5'  
  map.connect 'useful/:url', :controller => 'page',:active_tab=>'5'  
  map.connect 'feedback', :controller => 'feedback', :active_tab=>'6'  
  map.connect 'catalogue', :controller=>'catalogue'
  map.connect 'catalogue/wizard/:action',:controller=>'catalogue/wizard'
  map.connect 'catalogue/page/:page', :controller=>'catalogue'
  map.connect 'catalogue/:id', :controller=>'catalogue', :action=>'details'
  map.connect 'catalogue/:id/print',:controller=>'catalogue', :action=>'print'
  map.connect '/map', :controller=>'map'
  map.connect '/map/kievmapdata.xml', :controller=>'map', :action=>'kievmapdata'
  map.connect '/map/mapdata.xml', :controller=>'map', :action=>'mapdata'
  map.connect 'admin/page/:action/:id', :controller=>'admin/page'
  map.connect 'admin/owner/:action/:id', :controller=>'admin/owner'
  map.connect 'admin/agency/:action/:id', :controller=>'admin/agency'
  map.connect 'admin/catalogue/:action/:id', :controller=>'admin/catalogue'
  map.connect 'admin/contacts/:action/:id', :controller=>'admin/contacts'
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect '/javascripts/imagelist.js', :controller=>'picbrowser', :action=>'generate_image_list_javascript'
#  map.connect '/:id', :controller=>'catalogue', :action=>'details'

# Install the default route as the lowest priority.
  map.connect ':controller/:action/:id'
end
