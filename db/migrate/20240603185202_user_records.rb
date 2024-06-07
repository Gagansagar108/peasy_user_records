class UserRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.string :uuid
      t.string :gender
      t.jsonb :name
      t.jsonb :location
      t.integer :age
      t.date :date_of_entry
      t.string :query_data
      t.timestamps
    end

    create_table :user_records, id: :uuid, default: -> { 'gen_random_uuid()' } do |t|
      t.date :date_of_entry
      t.integer :male_count
      t.integer :female_count
      t.float :male_avg_age, scale: 2
      t.float :female_avg_age, scale: 2
      t.timestamps
    end 
    enable_extension :pg_trgm
    
    add_index :users, :uuid, unique: true
    add_index :users, :gender
    add_index :users, :date_of_entry
    add_index :user_records, :date_of_entry
    add_index :users, :query_data, using: :gin, opclass: :gin_trgm_ops
  end
end
