Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  unauthenticated :user do
    root to: "home#sign_in"
  end
  authenticated :user do
    root to: "home#index"
  end
  devise_scope :user do
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end
end
