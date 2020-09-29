# frozen_string_literal: true

# Helper module for Home controller
module HomeHelper
  def self.parse_transaction(text)
    trasactions = []
    line_count = 1
    text.each_line do |line|
      trasactions.push(new_transaction_from_line(line))
      line_count = + 1
    rescue StandardError => e
      raise "Erro ao ler linha #{line_count}, por favor verifique o arquivo."
    end
    trasactions
  end

  def self.calulate_total(loja)
    total = 0
    loja.each do |transaction|
      total = transaction.transaction_type.sinal == '+' ? total + transaction.valor : total - transaction.valor
    end
    total
  end

  private_class_method def self.new_transaction_from_line(line)
    Transaction.new({ tipo: line[0].to_i,
                      data: DateTime.parse(line[1...9] + 'T' + line[42...48]),
                      valor: (line[9...19].to_f / 100),
                      cpf: line[19...30],
                      cartao: line[30...42],
                      dono: line[48...62],
                      loja: line[62...81] })
  end
end
