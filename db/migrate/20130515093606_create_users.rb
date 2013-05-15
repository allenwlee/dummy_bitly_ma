class CreateUsers < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :name, :email, :password, :null => false

  		t.timestamps
  	end
  end
end
