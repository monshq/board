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

  def self.tagged_with(tags)
    inner_joins = tags.collect do |tag|
      tt = "items_tags_for_tag_#{tag.id}"
      "INNER JOIN items_tags AS #{tt} ON items.id = #{tt}.item_id AND #{tt}.tag_id = #{tag.id}"
    end

    joins(inner_joins.join(' '))
  end

  def set_tags(tags_s)
    self.tags = tags_s.split(',').map{|t| t.strip}.uniq.map do |t|
      unless self.id.nil?
        Tag.where(name: t.strip).first_or_create
      else
        Tag.new(name: t.strip)
      end
    end
  end

  def set_tags_hashes
    tags = self.tags.pluck(:name)
    hashes = TagsHash.get_hashes(tags)
    hashes.each do |h|
      self.tags_hashes << h
    end
    #self.tags_hashes.import hashes
  end

  def find_by_tags(tags)
    items = Item.joins(:tags_hashes).where('tags_hashes.tags_hash = ?', TagsHash.get_hashes(tags))
    p items.to_sql
  end

  def set_sale_date_time
    @sold_at = Time.new
  end

end
