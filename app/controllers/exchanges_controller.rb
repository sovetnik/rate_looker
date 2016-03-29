class ExchangesController < ApplicationController
  before_action :set_exchange

  def edit
  end

  def show
  end

  def update
    if @exchange.update(exchange_params)
      render :show
    else
      render :edit
    end
  end

  private

  def set_exchange
    @exchange = Exchange.find_or_create_by(iso_from: :usd, iso_to: :rub)
    @exchange.custom_rate ||= 0
  end

  def exchange_params
    params.require(:exchange).permit(:custom_rate, :expires_at)
  end
end
