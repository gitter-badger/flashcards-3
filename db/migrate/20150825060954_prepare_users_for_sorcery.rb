class PrepareUsersForSorcery < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :password, :crypted_password
      t.string :salt
    end
  end
end
