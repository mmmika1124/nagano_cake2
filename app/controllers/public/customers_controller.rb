class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
  end
end
