class CreateSpreeTrackings < ActiveRecord::Migration
  def change
    create_table :spree_trackings do |t|
      t.string      :number
      t.integer     :order_id
      t.text        :state

      t.timestamps
    end
  end
end
