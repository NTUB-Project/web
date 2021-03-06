class User < ApplicationRecord
has_many :comments
has_one :cart
has_many :cart_items
has_many :matters
has_many :matter_forms
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable ,:confirmable, :omniauthable, :omniauth_providers => [:facebook]

  def admin?
    role == "admin"
  end


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
