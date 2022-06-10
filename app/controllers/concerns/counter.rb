module Counter
  private
  def set_counter
    session[:counter] = session[:counter] ? session[:counter] + 1: 0
  end
  def reset_counter
    session[:counter] = 0
  end
end