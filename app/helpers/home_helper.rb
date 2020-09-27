# frozen_string_literal: true

# Helper module for Home controller
module HomeHelper
  def self.parse_transaction(text)
    trasactions = []
    text.each_line do |x, line|
      trasactions.push(new_transaction_from_line(line))
    rescue StandardError => e
      raise "Erro ao ler linha #{x}, por favor verifique o arquivo."
    end
    trasactions
  end

  private_class_method def self.new_transaction_from_line(line)
    Transaction.new({ tipo: line[0],
                      data: DateTime.parse(line[1...9] + 'T' + line[42...48]),
                      valor: (line[9...19].to_f / 100),
                      cpf: line[19...30],
                      cartao: line[30...42],
                      dono: line[48...62],
                      loja: line[62...81] })
  end
end
