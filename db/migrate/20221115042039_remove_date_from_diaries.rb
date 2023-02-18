class RemoveDateFromDiaries < ActiveRecord::Migration[6.1]
  def change
    remove_column :diaries, :day, :string
  end
end
