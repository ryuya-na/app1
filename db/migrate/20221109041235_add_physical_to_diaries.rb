class AddPhysicalToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :physical_condition, :string
    add_column :diaries, :physical_comment, :string
  end
end
