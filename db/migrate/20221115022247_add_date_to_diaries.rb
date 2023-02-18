class AddDateToDiaries < ActiveRecord::Migration[6.1]
  def change
    add_column :diaries, :diary_date, :date
  end
end
