class NoteMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.note_mailer.new_note_permission.subject
  #

  #função que da permissão ao usuario de editar a nota passada como parametro
  def new_note_permission note, user
    @note = note
    @user = user

    mail(to: @user.email, subject: 'Você recebeu um convite para editar uma nova nota')
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.note_mailer.permission_revoked.subject
  #

  #Função do controller Mail que envia a menagem para o usuario tirando o convite de ediçaão da nota passada como parametro
  def permission_revoked note, user
    @note = note
    @user = user

    mail(to: @user.email, subject: 'Permissão da edição da nota revogada')
  end
end
