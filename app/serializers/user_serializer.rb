class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :first_name, :last_name, :nickname, :bio, :user_type, :created_at
end
