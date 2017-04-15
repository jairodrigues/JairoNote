class TagsController < ApplicationController

  def add_to_note
    #Busca uma tag apartir dos parametros passados pelo usuario logado ou cria caso não exista
    #Função find_or_create_by faz parte do Active Record
    @tag = Tag.find_or_create_by(title: params[:title], user: current_user)
    #cria uma variavel apartir da busca de notas do usuario logado usando o id passado como parametro
    @note = current_user.notes.find params[:note_id]
    #inclui a tag criada ou buscada nas notas do usuario logado
    @note.tags << @tag

    render json: {message: "Tag adicionada com sucesso!"}, status: :ok;
  end

  def remove_from_note
    #Busca uma tag apartir dos parametros passados com base nas tags do usuario logado e joga isso na variavel tag
    @tag = Tag.find_by(title: params[:title], user: current_user)
    #Busca uma nota com base no parametro passado pela URL através do id
    @note = current_user.notes.find(params[:note_id])
    #Apaga a tag feita na primeira busca peo seu id vinculada a nota buscada
    @note.tags.delete(@tag.id)
    #apaga todas as tags caso não haja mais nenhuma nota vinculada a ela
    @tag.destroy if @tag.notes.count == 0

    render json: {message: "Tag removida com sucesso!"}, status: :ok

  end
end
