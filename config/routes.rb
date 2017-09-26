IosApi::Application.routes.draw do
  resources :books
  # get 'books' => 'books#books'

  get '/instructions' => 'books#instructions'
  match '/clean' => 'books#destroy_all', via: [:post, :delete]
end
