class AddTweetThisToPrefs < ActiveRecord::Migration
  def self.up
    Preference.new(:title => 'Show &quot;Tweet This&quot; button',:name => 'tweet_this',:description => 'Allows visitors to Tweet about posts',:value => '0').save
  end

  def self.down
    tweet_this = Preference.find_by_name('tweet_this')
    Preference.delete(tweet_this)
  end
end
