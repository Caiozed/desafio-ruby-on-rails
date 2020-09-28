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
    @trasactions = []

    file = params[:file]
    text = file.read
    begin
      @trasactions = HomeHelper.parse_transaction(text)
      Transaction.import(
        %i[tipo data valor cpf cartao dono loja],
        @trasactions
      )

      flash[:success] = 'Arquivo importado com sucesso!'
    rescue StandardError => e
      flash[:danger] = e.message
    end

    redirect_to action: 'index'
  end
end
