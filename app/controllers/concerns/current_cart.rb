module CurrentCart
  private
  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def destroy_cart
    @cart.destroy if @cart.id == session[:cart_id]  # Destroy the cart only if it belongs to the session.
    session["cart_id"] = nil
  end
end