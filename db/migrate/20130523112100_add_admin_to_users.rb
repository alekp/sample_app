class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

# generated with rails generate migration add_admin_to_users admin:boolean

# added default: false  so by default users are not admins  
# http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-admin_migration