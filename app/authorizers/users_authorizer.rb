class UsersAuthorizer < ApplicationAuthorizer
  def self.readable_by?(user)
    user.has_role? :admin
  end

  def readable_by?(user)
    # user.has_role?(:admin) || user.has_role?(:user)
    true
  end

  def updateable_by?(user)
    user.has_role? :admin
  end
end
