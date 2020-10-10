class AddSentByToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :sent_by, :integer
  end
end
