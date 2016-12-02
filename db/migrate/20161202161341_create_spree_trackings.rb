class CreateSpreeTrackings < ActiveRecord::Migration
  def change
    create_table :spree_trackings do |t|
      t.number :string

      t.timestamps
    end
  end
end
