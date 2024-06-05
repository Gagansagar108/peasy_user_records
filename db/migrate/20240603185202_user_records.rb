class UserRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.string :uuid
      t.string :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age
      t.timestamps
    end

    create_table :user_records, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.date :date
      t.integer :male_count
      t.integer :female_count
      t.float :male_avg_age
      t.float :female_avg_age
      t.timestamps
    end 

    add_index :users, :uuid, unique: true
    add_index :user_records, :date
    add_index :users, :gender
  end
end
