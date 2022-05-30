class WalletsController < ApplicationController
  before_action :set_wallet, only: %i[ show update destroy ]
  before_action :get_user
  before_action :authenticate_user!

  # GET /wallets
  def index
    @wallets = @user.wallets

    render json: @wallets
  end

  # GET /wallets/1
  def show
    render json: @wallet
  end

  # POST /wallets
  def create
    # @wallet = Wallet.new(wallet_params)
    @wallet = @user.wallets.build(wallet_params)

    if @wallet.save
      render json: @wallet, status: :created, location: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /wallets/1
  def update
    if @wallet.update(wallet_params)
      render json: @wallet
    else
      render json: @wallet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /wallets/1
  def destroy
    @wallet.destroy
  end

  def cash_in
    @wallet.cash_in(@wallet.id, params[:amount])
  end

  def cash_out
    @wallet.cash_out(@wallet.id, params[:amount])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
      @wallet = Wallet.find(params[:id])
    end

    def get_user
      @user = Wallet.find(2).user
    end

    # Only allow a list of trusted parameters through.
    def wallet_params
      params.require(:wallet).permit(:balance)
    end
end
