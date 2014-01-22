Stack::Application.routes.draw do

# url's for active admin (auto added)
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
# the routes files matches the url's with the controllers
  
  # i want to add in all the REST urls for stories
  # e.g index, show, new, create, edit, udate, destroy

  resources :stories do
  	# this is called a nested resource
  	# meaning the url's for comments are on the urls for stories
  resources :comments

# because votes are related to stories just like comments
  resources :votes

end

  # add a homepage
  
  root "stories#index"



end
