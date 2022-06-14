class LineItemsController < ApplicationController
  include CurrentCart, Counter
  before_action :set_cart, only: %i[create destroy]
  before_action :reset_counter, only: %i[create]
  before_action :set_line_item, only: %i[ show edit update destroy ]

  # GET /line_items or /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1 or /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items or /line_items.json
  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product) # Add the product to the cart
    respond_to do |format|
      if @line_item.save
        format.turbo_stream
        format.html { redirect_to store_index_url }
        format.json { render :show, status: :created, location: @line_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1 or /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to line_item_url(@line_item), notice: "Line item was successfully updated." }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1 or /line_items/1.json
  def destroy
    if @line_item.quantity > 1
      @line_item.quantity -=1
      @line_item.save!
    else
      @line_item.destroy
    end
    if @cart.line_items.count <= 0
      destroy_cart
      respond_to do |format|
        format.html { redirect_to store_index_url, notice: "Your cart is currently empty." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to store_index_url, notice: "Your cart was successfully updated." }
        format.json { head :no_content }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
