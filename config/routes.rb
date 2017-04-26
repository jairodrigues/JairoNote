Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Rotas para as notas, somente criação, alteração, index, vizualização de apenas uma nota e exclusão.
  resources :notes, only: [:create, :update, :index, :show, :destroy]
  
  root :to => "notes#index"

  #Criação de uma nota e seu id apartir de um id de um usuario
  post '/users/:id/add_note/:note_id', to: 'users#add_note'

  #Exclusão de uma nota apartir do id do usuario, da função remove_note e o id da nota
  delete '/users/:id/remove_note/:note_id', to: 'users#remove_note'

  #Criação de uma tag, enviando como parametro o nome, e a funcao a ser chamada no controller com o id da nota correspondente a tag e seu ID
  post '/tags/:title/add_to_note/:note_id', to: 'tags#add_to_note'

  #Exclusão da uma tag, enviando como parametro seu nome, a função remove do controller Nota e o id da nota correspondente a tag
  delete '/tags/:title/remove_from_note/:note_id', to: 'tags#remove_from_note'

end
