class Preference < ActiveRecord::Base
  
  def self.get_pref(setting_name)
    setting = setting_name.downcase
    if !@@preference[setting]
      pref = Preference.find(:first, :conditions => ['name = ?',setting])
      if pref
        @@preference[setting] = pref.value
        return pref.value
      end
      @@preference[setting] = ''
    else
      return @@preference[setting]
    end
  end
  
  def self.set_pref(name,value)
    setting = name.downcase
    pref = Preference.find(:first, :conditions => ['name = ?',name])
    if pref
      if pref.update_attribute(:value,value)
        flash[:notice] = "Preference (#{pref.title}) saved"
      end
      @@preference[name] = value
    end
  end
  
  def self.clear_stored_prefs
    @@preference.clear
  end
end
