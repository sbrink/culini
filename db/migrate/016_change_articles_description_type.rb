class ChangeArticlesDescriptionType < ActiveRecord::Migration
  def self.up
    change_column :articles, :description, :string
  end

  def self.down
    change_column :articles, :description, :text
  end

end
