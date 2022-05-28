require 'date'

class StocksController < ApplicationController
  before_action :set_stock, only: %i[ show update destroy ]

  # GET /stocks
  def index
    @stocks = Stock.all

    render json: @stocks
  end

  # GET /stocks/1
  def show
    render json: @stock
  end

  # POST /stocks
  def create
    # @stock = Stock.new(stock_params)

    # if @stock.save
    #   render json: @stock, status: :created, location: @stock
    # else
    #   render json: @stock.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /stocks/1
  def update
    if @stock.update(stock_params)
      render json: @stock
    else
      render json: @stock.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stocks/1
  def destroy
    @stock.destroy
  end

  def top_ten
    top_ten_array = Stock.top_ten
    render json: top_ten_array
  end

  def info
    stock_info = Stock.info(params[:symbol])
    render json: stock_info
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:symbol, :company, :price, :date_and_time)
    end
end
