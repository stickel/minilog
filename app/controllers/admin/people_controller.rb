class Admin::PeopleController < ApplicationController
  include AuthenticatedSystem
  
  layout 'admin'
  before_filter :login_required, :find_person, :only => [:suspend, :unsuspend, :destroy, :purge]
  helper :application
  
  def index
    $page_title = 'Accounts'
    @people = Person.all
  end
  
  def new
    $page_title = 'Create new account'
    @person = Person.new
  end
 
  def create
    logout_keeping_session!
    @person = Person.new(params[:person])
    @person.register! if @person && @person.valid?
    success = @person && @person.valid?
    if success && @person.errors.empty?
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up! We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry. Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def edit
    $page_title = 'Edit account'
    @person = Person.find(params[:id])
  end
  
  def update
    person = Person.find(params[:id])
    person.information = htmlize_copy(params[:person][:information_raw])

    if current_person.id == params[:id]
      # current person matches, they're editing their profile
      if !params[:person][:password].blank? && (params[:password_new] == params[:person][:password_confirmation])
        # passwords match, set the new password
        if Person.authenticate(current_person.login, params[:old_password])
          if (params[:person][:password] == params[:person][:password_confirmation]) && !params[:person][:password_confirmation].blank?
            person.password_confirmation = params[:person][:password_confirmation]
            person.password = params[:password_new]
          else
            render :action => 'edit'
          end
        else
          # old password doesn't match current password
          render :action => 'edit'
        end
      else
        # passwords don't match, try again
        render :action => 'edit'
      end
    end
    
    if person.update_attributes(params[:person])
      flash[:notice] = "Account updated!"
      redirect_to :back
    else
      # flash[:error] = "Problem updating account. Please try again. #{person.errors.inspect}"
      render :action => 'edit'
    end
  end

  def activate
    logout_keeping_session!
    person = Person.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && person && !person.active?
      person.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing. Please follow the URL from your email."
      redirect_back_or_default('/')
    else 
      flash[:error]  = "We couldn't find a person with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

  def suspend
    @person.suspend! 
    redirect_to people_path
  end

  def unsuspend
    @person.unsuspend! 
    redirect_to people_path
  end

  def destroy
    @person.delete!
    redirect_to people_path
  end

  def purge
    @person.destroy
    redirect_to people_path
  end
  
  # There's no page here to update or destroy a person.  If you add those, be
  # smart -- make sure you check that the visitor is authorized to do so, that they
  # supply their old password along with a new one to update it, etc.

protected
  def find_person
    @person = Person.find(params[:id])
  end
end
