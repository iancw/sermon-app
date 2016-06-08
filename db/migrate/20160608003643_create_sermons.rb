class CreateSermons < ActiveRecord::Migration
  def change
    create_table :sermons do |t|
      t.date :Date
      t.string :Passage
      t.string :Title
      t.string :Series
      t.string :Speaker

      t.timestamps null: false
    end
  end
end
