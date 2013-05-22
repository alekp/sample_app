class AddRememberTokenToUsers < ActiveRecord::Migration
  # http://ruby.railstutorial.org/chapters/sign-in-sign-out#code-add_remember_token_to_users
  def change
    # additionaly added after generate
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end
end
