class CreateUrls < ActiveRecord::Migration
  def change
  	create_table :urls do |t|
  		t.string :original_url, :short_url
  		t.integer :click_count, :default => 0
  		t.references :user 
      t.timestamps
    end
  end
end
