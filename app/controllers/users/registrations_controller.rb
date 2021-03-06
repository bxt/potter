class Users::RegistrationsController < Devise::RegistrationsController
  layout "sign_in", only: [:new, :create]
  
  def update
    @user = current_user
    
    if @user.update_attributes(user_params)
      redirect_to edit_user_registration_path, flash: {success: "Account erfolgreich aktualisiert!"}
    else
      render "edit"
    end
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      sign_in(@user)
      redirect_to success_path, flash: {success: "Erfolgreich registriert!"}
    else
      render "new"
    end
  end
  
  
  private
  
  def resource_params
    user_params
  end
  
  # def build_resource
  #   self.resource = User.new(user_params)
  # end
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation, :name, :email)
  end

  def success_path
    session[:return_to_path] || root_path
  end
end
