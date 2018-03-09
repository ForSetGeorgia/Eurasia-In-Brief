class TimePeriod < AddMissingTranslation
  #######################
  ## TRANSLATIONS

  translates :label, :slug,
              :fallbacks_for_empty_translations => true
  # Allows reference of specific translations, i.e. post.title_az
  # or post.title_en
  globalize_accessors

  #######################
  ## SLUGS
  extend FriendlyId
  friendly_id :label, :use => [:globalize, :slugged, :history]

  # for genereate friendly_id
  def should_generate_new_friendly_id?
#    name_changed? || super
    super
  end

  # for locale sensitive transliteration with friendly_id
  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end

  #######################
  ## VALIDATIONS

  validates :label, presence: :true
  validates :is_published, inclusion: { in: [true, false] }
  validates :order, numericality: { only_integer: true }

  #######################
  ## SCOPES
  scope :published, -> { where(is_published: true) }
  scope :sorted, -> { with_translations(I18n.locale).order('time_periods.order desc , time_period_translations.label asc') }

  def self.max_order
    sorted.limit(1).pluck(:order).first
  end

  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.label.present?
  end

  def add_missing_translations(default_trans)
    self.label = default_trans.label if self["label_#{Globalize.locale}"].blank?
  end

end
