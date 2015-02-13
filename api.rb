require 'sinatra'
require 'logger'

post '/stock' do
  logger = Logger.new(File.open('stock.log', 'a'))
  best_revenue = ''
  best_buy_stock, best_sell_stock = [], []
  params[:data].each_with_index do |buy_stock, i|
    buy_stock = buy_stock.split(',')
    buy_stock[1] = buy_stock[1].to_f
    timestamp1, price1 = buy_stock[0], buy_stock[1]

    params[:data][(i + 1)..-1].each_with_index do |sell_stock, j|
      sell_stock = sell_stock.split(',')
      sell_stock[1] = sell_stock[1].to_f
      timestamp2, price2 = sell_stock[0], sell_stock[1]

      best_revenue = price2 - price1 if best_revenue == ''

      revenue = price2 - price1
      if revenue > best_revenue
        best_buy_stock, best_sell_stock = buy_stock, sell_stock
        best_revenue = price2 - price1
      end
    end
  end

  logger.info "#{ params[:name] }, #{ best_buy_stock[0] }, #{ best_sell_stock[0] }"
  logger.close
end
