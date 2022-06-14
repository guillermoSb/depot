class StoreController < ApplicationController
  include Counter, CurrentCart
  before_action :set_counter, only: %i[index]
  before_action :set_cart
  def index
    @products = Product.order(:title) # Products that are going to be shown.
    @counter = session[:counter]
  end
end
