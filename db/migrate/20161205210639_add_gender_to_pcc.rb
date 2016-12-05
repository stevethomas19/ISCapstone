class AddGenderToPcc < ActiveRecord::Migration
  def change
    add_column :pcc_infos, :gender, :string
  end
end
