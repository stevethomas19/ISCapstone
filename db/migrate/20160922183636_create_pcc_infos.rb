class CreatePccInfos < ActiveRecord::Migration
  def change
    create_table :pcc_infos do |t|
      t.boolean :filed
      t.string :pcc
      t.string :report
      t.integer :tran_id
      t.string :tran_type
      t.date :tran_date
      t.decimal :tran_amt
      t.boolean :inkind
      t.boolean :loan
      t.string :amends
      t.string :name
      t.string :purpose
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :inkind_comments

      t.timestamps null: false
    end
  end
end
