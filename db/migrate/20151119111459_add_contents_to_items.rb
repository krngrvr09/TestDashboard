class AddContentsToItems < ActiveRecord::Migration
  def change
    add_column :items, :contents, :string
  end
end
