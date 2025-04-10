class RemoveItemCategoryFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :item_category_id, :integer
  end
end
