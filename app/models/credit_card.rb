TYPES_CREDIT_CARDS = {
  visa: /^4[0-9]{12}(?:[0-9]{3})?$/,
  mastercard: /^5[1-5][0-9]{14}$/,
  jcb: /^(?:2131|1800|35\d{3})\d{11}$/,
  diners: /^3(?:0[0-5]|[68][0-9])[0-9]{11}$/,
  discover: /^6(?:011|5[0-9]{2})[0-9]{12}$/,
  amex: /^3[47][0-9]{13}$/
}.freeze
class CreditCard
  def initialize(number_credit_card)
    @credit_card = number_credit_card || ''
  end

  def franchise
    cc_franchise = nil
    TYPES_CREDIT_CARDS.each do |k, v|
      cc_franchise = k if @credit_card =~ v
    end
    cc_franchise
  end

  def four_digits
    @credit_card.last(4).to_s
  end

  def encryption
    BCrypt::Password.create(@credit_card)
  end
end
