class NotesController < ApplicationController

  #User_curret(método do DEVISE para usuario logado)

  #Execulte o método set_note do filtro do controller nas funções update, destroy e show
  before_filter :set_note, only: [:update, :destroy, :show]


  def index
    #Crio uma variavel com todos as notas do usuario logado + todas as notas que o usuario logado foi convidado
    #O sinal + significa uma soma de Arrays
    @notes = current_user.notes + current_user.guest_notes
    #Renderiza no formato json todas as notas incluindo os dados de records(modelo) relacionados dos usuarios convidados e as tags relacionadas dela
    #render :json => @notes.to_json(:include => [:users, :tags])

  end


  #método usado para mostrar somente uma nota (um record)
  def show
    #Renderiza no formato json dados da nota incluindo dados dos usuario e das tags relacionadas
    #Método to_json inclui dados relacionados de outros modelos dentro do documento criado
    render :json => @note.to_json(:include => [:users, :tags])
  end


  def create
    #cria um novo objeto do tipo nota e merge(incluir) o usuario atual do sistema
    @note = Note.new(note_params.merge(user: current_user))

    if @note.save
      #método de resposta Json para um acesso assincrono entre o front e o back-end, trazendo uma mensagem, com o status, no caso code HTTP : 201
      render json: {message: "Nota criada com sucesso!"}, status: :created
    elsif
      #Traz uma mensagem de falha através de um render JSON, com o status, no caso de erro ao criar nota error HTTP : 422
      render json: {message: "Falha ao criar a nota!"}, status: :unprocessable_entity
    end
  end

  def update
    #condição se o usuario decidir atualizar as notas com os parametros do método note_params
    if @note.update(note_params)
      render json: {message: "Nota atulizada com sucesso!"}, status: :ok
    else
      render json: {message: "Falha ao atualizar a nota!"}, status: :unprocessable_entity
    end
  end

  def destroy
    #condição se o current_user(usuario atual) desejar excluir a nota setada pelo método set_note e execultada através do método before_filter no método destroy
    @note.destroy
    render json: {message: "Nota excluida com sucesso!"}, status: :ok
    #Não foi colocado else pois caso a exclusão de errado será enviado um motodo com erro HTTP code 500
  end


  private

    def set_note
      #cria uma variavel que busca todos os atributos do objeto note apartir do ID passado
      @note = current_user.notes.find_by(id: params[:id])
      #caso nao tenha nenhuma nota minha(variavel acima seja vazia), mostrar apenas as notas que eu fui convidado
      @note = current_user.guest_notes.find params[:id] unless @note.present?

    end

    def note_params
      #Utiliza os parametro requiridos pelo usuario da nota permitindo somente o titulo e o corpo da nota (tira os campos de data de criação por exemplo, so passando os parametros que serão realmente utilizados)
      params.require(:note).permit(:title, :body)
    end


end
