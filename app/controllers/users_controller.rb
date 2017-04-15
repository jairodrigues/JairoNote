class UsersController < ApplicationController

  before_filter :set_user, only: [:add_note, :remove_note]

  #adiciona nota ao usuario
  def add_note
    #cria uma variavel nota e busca através do id enviado pela URL a nota do usuario logado
    @note = current_user.notes.find params[:note_id]
    #adiciona a nota a um usuario convidado
    @user.guest_notes << @note

    render json: {message: "Compartilhamento bem sucedido!"}, status: :ok
  end

  def remove_note
    #metodo params[:nota_id] é o id da nota através da URL
    #metodo current_user.notes.find busac todas as notas do usuario logado no sistema
    @note = current_user.notes.find params[:note_id]
    #Apaga o acesso a nota do usuario convidado (Nota é passada com parametro pela URL)
    @user.guest_notes.delete(@note.id)

    render json: {message: "Permissão revogada com sucesoo!"}, status: :ok
  end

  private

  def set_user
    #Busca todos os usuarios pelo email passado como parametro pela URL
    #find_by é um metodo de busca por campos personalizados
    @user = User.find params[:id]
  end


end
