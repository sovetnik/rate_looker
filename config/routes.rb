Rails.application.routes.draw do
  root 'exchanges#show'
  get 'admin', to: 'exchanges#edit'
  patch 'exchange', to: 'exchanges#update'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
