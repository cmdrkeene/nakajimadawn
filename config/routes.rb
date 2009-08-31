ActionController::Routing::Routes.draw do |map|
  map.resource 'sync', :controller => 'sync'
  map.root :controller => "homepage"
end
