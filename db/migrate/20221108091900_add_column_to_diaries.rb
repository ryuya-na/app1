class AddColumnToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :mental_condition, :string
    add_column :diaries, :mental_comment, :string
    add_column :diaries, :day, :string
  end
end
