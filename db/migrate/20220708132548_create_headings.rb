# frozen_string_literal: true

class CreateHeadings < ActiveRecord::Migration[6.1]
  def change
    create_table :headings do |t|
      t.string :tag_type
      t.text :data
      t.references :member, null: false, foreign_key: true

      t.timestamps
    end
  end
end
