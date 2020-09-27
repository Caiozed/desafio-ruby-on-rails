# frozen_string_literal: true

# Home controller for retrieval of data
class HomeController < ApplicationController
  include HomeHelper

  def index
    transactions = Transaction.all
    @lojas = transactions.group_by(&:loja)
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

      flash[:success] = 'It worked!'
    rescue StandardError => e
      flash[:warning] = e.message
    end

    redirect_to action: 'index'
  end
end
