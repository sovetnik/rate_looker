class ExchangesController < ApplicationController
  before_action :set_exchange

  def edit
  end

  def show
  end

  def update
    @exchange.update(exchange_params)
    redirect_to root_path
  end

  private

  def set_exchange
    @exchange = Exchange.find_or_create_by(iso_from: :usd, iso_to: :rub)
  end

  def exchange_params
    params.require(:exchange).permit(:custom_rate, :expires_at)
  end
end
