class CreatePreferences < ActiveRecord::Migration
  def self.up
    create_table :preferences do |t|
      t.column :title, :string, :null => false
      t.column :name, :string, :null => false
      t.column :description, :text, :null => false
      t.column :value, :text, :null => false
    end
    
    # create default preferences
    Preference.new(:title => 'Domain',:name => 'domain',:description => 'Your site’s domain (do not include http://)',:value => '').save
    Preference.new(:title => 'Site name',:name => 'site_name',:description => 'Your site’s name',:value => 'My site').save
    Preference.new(:title => 'Slogan',:name => 'slogan',:description => 'The slogan/tagline for your site',:value => 'The best site evar!').save
    Preference.new(:title => 'Site description',:name => 'site_description',:description => 'Short description of your site',:value => 'My site is so awesome, everyone reads it every day.').save
    Preference.new(:title => 'Site owner',:name => 'owner_name',:description => 'Site owner’s name',:value => 'me').save
    Preference.new(:title => 'Site owner email',:name => 'owner_email',:description => 'Site owner’s email',:value => 'me@mysite.com').save
    Preference.new(:title => 'Items on index page',:name => 'items_on_index',:description => 'How many items would you like to show on the index page?',:value => '10').save
    Preference.new(:title => 'Items in feed',:name => 'items_in_feed',:description => 'How many items would you like to show in your feed?',:value => '20').save
    Preference.new(:title => 'Your timezone',:name => 'timezone',:description => 'What is your local timezone?',:value => 'Pacific Time (US & Canada)').save
    Preference.new(:title => 'Language code',:name => 'language',:description => 'What language is this site?',:value => 'en-us').save
    Preference.new(:title => 'Metrics code',:name => 'metrics',:description => 'Add your site metrics code',:value => '').save
    Preference.new(:title => 'Time/Date format',:name => 'time_format',:description => 'How would you like the time displayed?',:value => '%B %d, %Y').save
    Preference.new(:title => 'Archive path name',:name => 'archive_path_name',:description => 'Choose a name for your archives',:value => 'archives').save
    
  end

  def self.down
    drop_table :preferences
  end
end