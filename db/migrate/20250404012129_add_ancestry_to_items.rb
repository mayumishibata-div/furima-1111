class AddAncestryToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :ancestry, :string
  end
end
