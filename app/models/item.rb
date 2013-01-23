class Item < ActiveRecord::Base
  attr_accessible :description, :contact_info, :state, :sold_at

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :tags, uniq: true
  has_many :photos,   dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :contact_info, presence: true,
                           length: {in: 11..255}
                           
  state_machine :initial => :hidden do
    after_transition any - :sold => :sold, :do => :set_sale_date_time

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

    state :hidden, :sold do
      def visible?
        false
      end
    end

    state :published do
      def visible?
        true
      end
    end
  end

  def set_tags(tags_s)
    tags_s.split(',').each do |t|
      self.tags << Tag.where(name: t.strip).first_or_create
    end
  end

  #sets item sale date
  def set_sale_date_time
    @sold_at = Time.new
  end

end
