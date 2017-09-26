IosApi::Application.routes.draw do
  resources :books
  match '/clean' => 'books#destroy_all', via: [:post, :delete]
end
