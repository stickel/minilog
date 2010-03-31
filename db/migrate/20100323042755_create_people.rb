class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table "people", :force => true do |t|
      t.column :login,                     :string, :limit => 40
      t.column :name,                      :string, :limit => 100, :default => '', :null => true
      t.column :email,                     :string, :limit => 100
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string, :limit => 40
      t.column :remember_token_expires_at, :datetime
      t.column :activation_code,           :string, :limit => 40
      t.column :activated_at,              :datetime
      t.column :state,                     :string, :null => :no, :default => 'passive'
      t.column :deleted_at,                :datetime
    end
    add_index :people, :login, :unique => true
    
    puts 'Adding default admin'
    
    temp_admin = Person.new :name => 'Admin', :login => 'admin', :email => 'me@mysite.com', :password => 'temppass', :password_confirmation => 'temppass'
    temp_admin.save
    # create activation code
    activation_code = Person.make_token
    temp_admin.activation_code = activation_code
    temp_admin.update_attribute(:activation_code, activation_code)
    # make the admin active now
    temp_admin.update_attribute(:state, 'active')
    temp_admin.update_attribute(:activated_at,Time.zone.now.utc.to_s(:db))
  end

  def self.down
    drop_table "people"
  end
end
