Rails.application.routes.draw do
  # resources :posts

  root 'posts#index'

  namespace :api, :defaults => { :format => :json } do
		namespace :v1 do
			get 'pages/test', to: 'pages#test'
			post 'pages/uploadPackagesV2', to: 'pages#uploadPackagesV2'
			get 'pages/getPackages', to: 'pages#getPackages'
		end
	end

	get '*unmatchedroute', to: redirect('/')

end
