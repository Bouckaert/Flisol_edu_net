class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:openredu]

  def self.from_omniauth(auth)
    where(provider: 'openredu', uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.login = auth.info.login 
      user.token = auth.credentials.token
    end
  end
end
