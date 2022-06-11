class CombinePriceForLineItems < ActiveRecord::Migration[7.0]
  def up
    LineItem.where("price IS NULL").each do |line_item|
      line_item.price = line_item.product.price
      line_item.save!
    end
  end

  def down
    LineItem.all.each do |line_item|
      line_item.price = nil
      line_item.save!
    end
  end
end