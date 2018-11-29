Rails.application.routes.draw do
  # resources :posts

  namespace :api, :defaults => { :format => :json } do
		namespace :v1 do
			resources :pages
		end
	end
end
