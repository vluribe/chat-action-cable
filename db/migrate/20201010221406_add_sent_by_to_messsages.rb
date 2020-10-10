class AddSentByToMesssages < ActiveRecord::Migration[6.0]
  def change
    add_column :messsages, :sent_by, :int
  end
end
