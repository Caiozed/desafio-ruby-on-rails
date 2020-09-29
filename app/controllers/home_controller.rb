# frozen_string_literal: true

# Home controller for retrieval of data
class HomeController < ApplicationController
  include HomeHelper
  skip_before_action :verify_authenticity_token

  def index
    transactions = Transaction.order(data: :desc)
    @lojas = transactions.group_by(&:loja)
    respond_to do |format|
      format.json { render json: @lojas }
      format.html
    end
  end

  def upload
    @transactions = []
    message = 'Arquivo importado com sucesso!'
    file = params[:file]
    begin
      text = file.read
      @transactions = HomeHelper.parse_transaction(text)
      Transaction.import(
        %i[tipo data valor cpf cartao dono loja],
        @transactions
      )

      flash[:success] = message
    rescue StandardError => e
      message = e.message
      flash[:danger] = e.message
    end

    respond_to do |format|
      format.json { render json: { message: message } }
      format.html { redirect_to action: 'index' }
    end
  end
end
