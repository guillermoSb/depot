class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # Products that are going to be shown.
  end
end
