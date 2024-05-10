require_relative 'negatives_not_allowed'
class StringCalculator

  DELIMITER = ",|\n"
  MAX_VALUE = 1000

  def add(numbers)
    numbers.strip!

    return 0 if numbers.empty?

    match = numbers.match(/\/\/(.*?)\n(.*)/)

    delimiter = match ? match[1] : DELIMITER

    split_numbers = numbers.split(/#{delimiter}|\n/)
    negative_numbers = split_numbers.select { |num| num.to_i.negative? }
    raise NegativesNotAllowed.new("Negatives Not Allowed: #{negative_numbers.join(', ')}") unless negative_numbers.empty?

    split_numbers.select { |num| num.to_i <= MAX_VALUE && num.to_i >= 0 }.map(&:to_i).reduce(0, &:+)
  end
end
