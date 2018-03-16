class Country < AddMissingTranslation
  #######################
  ## ASSOCIATIONS
  has_many :stories, dependent: :destroy

  #######################
  ## TRANSLATIONS

  translates :name, :leader, :slug,
              :fallbacks_for_empty_translations => true
  # Allows reference of specific translations, i.e. post.title_az
  # or post.title_en
  globalize_accessors

  #######################
  ## SLUGS
  extend FriendlyId
  friendly_id :name, :use => [:globalize, :slugged, :history]

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

  validates :name, presence: :true
  validates :lat, numericality: true, unless: Proc.new { |x| x.lat.blank? }
  validates :lon, numericality: true, unless: Proc.new { |x| x.lon.blank? }

  #######################
  ## SCOPES
  scope :sorted, -> { with_translations(I18n.locale).order('country_translations.name asc') }

  #######################
  #######################
  private

  def has_required_translations?(trans)
    trans.name.present?
  end

  def add_missing_translations(default_trans)
    self.name = default_trans.name if self["name_#{Globalize.locale}"].blank?
  end

end
