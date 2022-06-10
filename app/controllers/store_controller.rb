class StoreController < ApplicationController
  include Counter
  before_action :set_counter, only: %i[index]
  def index
    @products = Product.order(:title) # Products that are going to be shown.
    @counter = session[:counter]
  end
end
