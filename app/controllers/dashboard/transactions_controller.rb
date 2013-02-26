class Dashboard::TransactionsController < ApplicationController
  def index
    @transactions = current_user.transactions.order('created_at DESC')
  end
end
