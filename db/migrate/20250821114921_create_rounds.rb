class CreateRounds < ActiveRecord::Migration[8.0]
  def change
    create_table :rounds do |t|
      t.string :player_choice, null: false
      t.string :computer_choice, null: false
      t.string :result, null: false

      t.timestamps
    end
  end
end

