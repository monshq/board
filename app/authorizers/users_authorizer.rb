class UsersAuthorizer < ApplicationAuthorizer

  class << self

    def creatable_by?(user)
      (user.has_role?(:admin))
    end

    def readable_by?(user)
      (user.has_role?(:admin) || user.has_role?(:user))
    end

    def managable_by?(user)
      (user.has_role?(:admin))
    end

  end

  def readable_by?(user)
    (user.has_role?(:admin) || user.has_role?(:user))
  end

  def becomable_by?(user)
    (user.has_role?(:admin) && !resource.has_role?(:admin))
  end

  def creatable_by?(user)
    (user.has_role?(:admin) && !resource.has_role?(:admin))
  end

  def managable_by?(user)
    (user.has_role?(:admin) && !resource.has_role?(:admin))
  end
end
