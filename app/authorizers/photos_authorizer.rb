class PhotosAuthorizer < ApplicationAuthorizer

  class << self

    def readable_by?(user)
      true
    end

  end

  def updatable_by?(user)
  end
end
