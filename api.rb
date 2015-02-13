require 'sinatra'
require 'logger'


post '/stock' do
  logger = Logger.new(File.open('stock.log', 'a'))
  best_revenue = 0
  buy_index = 0
  sell_index = 1
  params[:data].each_with_index do |stock1, i|
    stock1 = stock1.split(',')
    stock1[1] = stock1[1].to_f
    timestamp1, price1 = stock1[0], stock1[1]

    params[:data][(i + 1)..-1].each_with_index do |stock2, j|
      stock2 = stock2.split(',')
      stock2[1] = stock2[1].to_f
      timestamp2, price2 = stock2[0], stock2[1]

      best_revenue = price2 - price1 if best_revenue == 0

      revenue = price2 - price1
      if revenue > best_revenue
        buy_index, sell_index = i, j
      end
    end
  end

  logger.info "#{ params[:name] }, #{ params[:data][buy_index] }, #{ params[:data][sell_index] }"
  logger.close
end
