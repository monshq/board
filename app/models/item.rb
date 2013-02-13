class Item < ActiveRecord::Base
  resourcify

  include Authority::Abilities

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :description, :contact_info, :state, :sold_at

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :tags, uniq: true
  has_many :photos,   dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :tags_hashes, dependent: :destroy

  validates :contact_info, length: {in: 11..255}, allow_blank: true
  validates :contact_info, presence: true

  tire.mapping do
    indexes :description
    indexes :contact_info
  end

  scope :published, lambda { where("state = ?", :published) }
  scope :active, lambda { where("state <> ?", :archived) }
  scope :archived, lambda { where("state = ?", :archived) }
  scope :with_messages, lambda { uniq.joins(:messages) }

  state_machine :initial => :hidden do
    before_transition :on => :archivate do |item|
      item.messages.active.map(&:archivate)
      item.photos.active.map(&:archivate)
    end

    after_transition any - :archived => :sold, :do => :set_sale_date_time

    event :publish do
      transition :hidden => :published
    end

    event :archivate do
      transition any => :archived
    end

    event :sell do
      transition :hidden => :sold
      transition :published => :sold
    end

    event :hide do
      transition :published => :hidden
    end

    event :archivate do
      transition :hidden => :archived
      transition :published => :archived
      transition :sold => :archived
    end

    state :hidden, :sold, :archived do
      def visible?
        false
      end
    end

    state :published do
      def visible?
        true
      end
    end

    state :archived do
      def visible_for_seller?
        false
      end
    end

    state  :hidden, :sold, :published do
      def visible_for_seller?
        true
      end
    end
  end

  def set_tags(tags)
    tags = tags.uniq

    item_tag_hashes = self.tags_hashes.to_a
    self.tags_hashes = TagsHash.get_hashes_with_relevance(tags).map do |t|
      item_tag_hashes.find{|h| h.tags_hash == t[:hash] && h.relevance == t[:relevance]} ||
        TagsHash.new(tags_hash: t[:hash], relevance: t[:relevance])
    end

    self.tags = tags.map do |t|
        Tag.where(name: t).first_or_initialize
    end
  end

  def self.tagged_with(tags)
    Item.joins(:tags_hashes).where('tags_hashes.tags_hash = ?', TagsHash.get_tags_hash(tags)).order('tags_hashes.relevance')
  end

  def set_sale_date_time
    @sold_at = Time.new
  end

end
