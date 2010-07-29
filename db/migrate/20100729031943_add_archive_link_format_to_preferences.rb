class AddArchiveLinkFormatToPreferences < ActiveRecord::Migration
  def self.up
    Preference.new(:title => 'Archive Link Format',:name => 'archive_link_format',:description => 'Choose how links to your archives will display',:value => 'list').save
  end

  def self.down
    Preference.find_by_name('archive_link_format').delete
  end
end
