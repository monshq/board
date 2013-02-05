class Item < ActiveRecord::Base
  resourcify

  include Authority::Abilities

  attr_accessible :description, :contact_info, :state, :sold_at

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :tags, uniq: true
  has_many :photos,   dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :contact_info, length: {in: 11..255}, allow_blank: true
  validates :contact_info, presence: true

  state_machine :initial => :hidden do
    after_transition any - :archived => :sold, :do => :set_sale_date_time

    event :publish do
      transition :hidden => :published
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

  scope :active, lambda { where("state <> ?", :archived) }
  scope :archived, lambda { where("state = ?", :archived) }
  scope :with_messages, lambda { uniq.joins(:messages) }

  def self.tagged_with(tags)
    inner_joins = tags.collect do |tag|
      tt = "items_tags_for_tag_#{tag.id}"
      "INNER JOIN items_tags AS #{tt} ON items.id = #{tt}.item_id AND #{tt}.tag_id = #{tag.id}"
    end

    joins(inner_joins.join(' ')).uniq
  end

  def set_tags(tags_s)
    tags_s.split(',').each do |t|
      self.tags << Tag.where(name: t.strip).first_or_create
    end
  end

  def set_sale_date_time
    @sold_at = Time.new
  end

end
