class ItemsAuthorizer < ApplicationAuthorizer
  def updatable_by?(user)
    (user.id == resource.seller_id)
  end

  def managable_by?(user)
    user.has_role? :admin
  end
end
