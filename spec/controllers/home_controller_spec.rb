require 'rails_helper'
require 'json'
require 'home_helper'

RSpec.describe 'Transactions', type: :request do
  let(:file) { fixture_file_upload(file_fixture('CNAB.txt')) }
  let(:file_invalid) { fixture_file_upload(file_fixture('CNAB_invalid.txt')) }

  let(:transactions) { HomeHelper.parse_transaction('3201903010000014200096206760174753****3153153453JOÃO MACEDO   BAR DO JOÃO    ') }

  it 'should render initial view' do
    get '/'
    expect(response).to be_successful
    expect(response.body).to include('BycodersTest')
  end

  context "when there's no transactions in the database" do
    it 'should retrieve empty object' do
      get '/', params: { format: :json }
      expect(JSON.parse(response.body)).to eq({})
    end
  end

  it 'should retrieve transaction grouped by "loja"' do
    Transaction.import(
      %i[tipo data valor cpf cartao dono loja],
      transactions
    )

    grouped_transactions = transactions.group_by(&:loja)

    get '/', params: { format: :json }
    expect(response.body).to eq(grouped_transactions.to_json)
  end

  it 'should upload file with success message' do
    post '/upload', params: { format: :json, file: file }
    expect(response.body).to eq({ message: 'Arquivo importado com sucesso!' }.to_json)
  end

  it 'should upload file with success message' do
    post '/upload', params: { format: :json, file: file }
    expect(response.body).to eq({ message: 'Arquivo importado com sucesso!' }.to_json)
  end

  it 'should upload file with error message' do
    post '/upload', params: { format: :json, file: file_invalid }
    expect(response.body).to include('Erro ao ler linha')
  end
end
