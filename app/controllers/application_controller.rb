class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include CanCan::ControllerAdditions

  #TODO: remover linha - somente teste
  #comando scapa da verificação feita na primeira linha, enviando um token configurado 
  skip_before_filter :verify_authenticity_token
end
