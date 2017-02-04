defmodule TaxCalc do
  def calculate(orders, tax_rates) do
    Enum.map(orders, &(add_tax(&1, tax_rates)))
  end

  def add_tax(order = [id: _, ship_to: state_code, net_amount: net_price], tax_rates) do
    tax_rate = Keyword.get(tax_rates, state_code, 0)
    total_price = Float.floor((net_price + net_price * tax_rate), 2)
    Keyword.put_new(order, :total_amount, total_price)
  end
end

ExUnit.start

defmodule TaxCalcTest do
  use ExUnit.Case

  test "test" do
    tax_rates =  [ NC: 0.075, TX: 0.08 ]

    orders = [
        [ id: 123, ship_to: :NC, net_amount: 100.00 ],
        [ id: 124, ship_to: :OK, net_amount:  35.50 ],
        [ id: 125, ship_to: :TX, net_amount:  24.00 ],
        [ id: 126, ship_to: :TX, net_amount:  44.80 ],
        [ id: 127, ship_to: :NC, net_amount:  25.00 ],
        [ id: 128, ship_to: :MA, net_amount:  10.00 ],
        [ id: 129, ship_to: :CA, net_amount: 102.00 ],
        [ id: 130, ship_to: :NC, net_amount:  50.00 ]
    ]

    sorted_orders = [
            [total_amount: 107.5,  id: 123, ship_to: :NC, net_amount: 100.0],
            [total_amount: 35.5,   id: 124, ship_to: :OK, net_amount: 35.5],
            [total_amount: 25.92,  id: 125, ship_to: :TX, net_amount: 24.0],
            [total_amount: 48.38,  id: 126, ship_to: :TX, net_amount: 44.8],
            [total_amount: 26.87,  id: 127, ship_to: :NC, net_amount: 25.0],
            [total_amount: 10.0,   id: 128, ship_to: :MA, net_amount: 10.0],
            [total_amount: 102.0,  id: 129, ship_to: :CA, net_amount: 102.0],
            [total_amount: 53.75,  id: 130, ship_to: :NC, net_amount: 50.0]
    ]

    expected = TaxCalc.calculate(orders, tax_rates)
    assert expected == sorted_orders
  end
end
