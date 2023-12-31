require 'debug'
class Menu
  attr_reader :name, :price

  def initialize(name,price)
    @name = name
    @price = price
  end

  def info
    "#{name}で#{price}円になります"
  end

  def get_total_price(count)
    if count >= 3
      return discounted_total_price(count)
    end
    price * count
  end

  private

  def discounted_total_price(count)
    (price * count) - discount_by_rate(count)
  end

  def discount_by_rate(count)
    # debugger
    discount_by_price * discount_by_count(count)
  end

  def discount_by_price
    if price >= 3000
      500
    elsif price >= 2000
      400
    elsif price >= 1000
      200
    elsif price >= 1000
      100
    else
      50
    end
  end

  def discount_by_count(count)
    if count >= 9
      6
    elsif count >= 7
      4
    elsif count >= 5
      3
    else
      2
    end
  end

end
