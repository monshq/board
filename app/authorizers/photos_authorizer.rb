class PhotosAuthorizer < ApplicationAuthorizer

  class << self

    def readable_by?(user)
      true
    end

  end

  def updatable_by?(user)
    (user.id == resource.item.seller_id)
  end

  def managable_by?(user)
    user.has_role? :admin
  end
end
