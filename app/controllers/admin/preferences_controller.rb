class Admin::PreferencesController < ApplicationController
  layout 'admin'
  def index
    $page_title = 'Admin : Preferences'
    @prefs = {}
    preferences = Preference.find(:all)
    preferences.each do |p|
      sub_hash = {}
      sub_hash['title'] = p.title
      sub_hash['description'] = p.description
      sub_hash['value'] = p.value
      @prefs[p.name] = sub_hash
    end
  end
  
  def save
    params[:preferences].each do |key, value|
      # turn numbers into numbers
      if key == 'items_on_index' or key == 'items_in_feed'
        value = value.to_i.abs.to_s
      end
      # strip http:// from domain
      if key == 'domain'
        value = value.gsub('http://','')
      end
      pref = Preference.find(:first, :conditions => ['name = ?',key])
      pref.value = value
      if !pref.save
        flash[:error] = "Could not save the #{key} preference"
        render :action => :index
      end
    end
    # Got to clear the @@preference hash after the prefs have been saved
    Preference.clear_stored_prefs
    
    flash[:notice] = "Preferences saved!"
    redirect_to admin_preferences_url
  end
end
