class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show update destroy ]
  before_action :get_wallet
  # before_action :authenticate_user!

  # GET /transactions
  def index
    @transactions = @wallet.transactions.sort_by {
      |transaction| transaction.created_at
    }

    render json: @transactions
  end

  # GET /transactions/1
  def show
    render json: @transaction
  end

  # POST /transactions
  def create
    @transaction = @wallet.transactions.build(transaction_params)

    if @transaction.save
      render json: @transaction, status: :created, location: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /transactions/1
  def update
    if @transaction.update(transaction_params)
      render json: @transaction
    else
      render json: @transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    @transaction.destroy
  end

  def buy
    @transaction = Transaction.buy(params[:wallet_id], params[:symbol], params[:shares].to_i)
    render json: @transaction, status: :created
  end

  def sell
    @transaction = Transaction.sell(params[:wallet_id], params[:symbol], params[:shares].to_i)
    render json: @transaction, status: :created
  end

  def portfolio
    portfolio = []
    @transactions = @wallet.transactions.map { |x| x.slice('action', 'shares', 'symbol') }
    @transactions.each do |item|
      has_item = true
      portfolio.each do |stock|
        if stock.to_h.has_value?(item['symbol'])
          has_item = true
            if item['action'] == 'buy'
              stock['shares'] = (stock['shares'] + item['shares'])
            elsif item['action'] == 'sell'
              stock['shares'] = (stock['shares'] - item['shares'])
            end
          break
        else
          has_item = false
        end
      end
      if portfolio == [] || has_item == false
        portfolio.push(item)
      end
    end
    portfolio = portfolio.map { |x| x.slice('shares', 'symbol') }


    render json: [portfolio]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    def get_wallet
      @wallet = Wallet.find(params[:wallet_id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:symbol, :company, :shares, :type, :amount, :price)
    end
end
