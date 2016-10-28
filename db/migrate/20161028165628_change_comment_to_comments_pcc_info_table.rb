class ChangeCommentToCommentsPccInfoTable < ActiveRecord::Migration
  def change
    rename_column :pcc_infos, :inkind_comment, :inkind_comments
  end
end
