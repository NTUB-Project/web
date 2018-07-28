class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable, :omniauthable, :omniauth_providers => [:facebook]

  def admin?
    role == "amin"
  end

  acts_as_commontator



  def self.from_omniauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)

    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email

      user = User.where(email: email).first if email

      if user.nil?
        user = User.new(email: auth.info.email,
                        password: Devise.friendly_token[0,20])

        user.skip_confirmation!
        user.save
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def delete_access_token(auth)
    @graph ||= Koala::Facebook::API.new(auth.credentials.token)
    @graph.delete_connections(auth.uid, "permissions")
  end

end
