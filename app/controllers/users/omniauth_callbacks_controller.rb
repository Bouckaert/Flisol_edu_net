class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def openredu
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    p '=========== USER'

    if @user.persisted?
      P 'user.persisted?'
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, kind: "Openredu") if is_navigational_format?
    else
      p 'else'
      redirect_to new_user_registration_path
    end
  end

  def failure
    redirect_to root_path
  end

end