Rails.application.routes.draw do
  # resources :posts

  root 'posts#index'

  namespace :api, :defaults => { :format => :json } do
		namespace :v1 do
			resources :pages
		end
	end

	get '*unmatchedroute', to: redirect('/')

end
