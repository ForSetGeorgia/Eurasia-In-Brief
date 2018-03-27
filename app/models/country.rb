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
  ## ATTACHED FILE
  has_attached_file :leader_image,
                    :url => "/system/country/:id/leader/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "150>"},
                        :'medium' => {:geometry => "500>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }
  has_attached_file :flag_image,
                    :url => "/system/country/:id/flag/:style/:basename.:extension",
                    :styles => {
                        :'thumb' => {:geometry => "50>"},
                        :'medium' => {:geometry => "100>"}
                    },
                    :convert_options => {
                      :'thumb' => '-quality 85'
                    }

  #######################
  ## VALIDATIONS

  validates :name, presence: :true
  validates :lat, numericality: true
  validates :lon, numericality: true
  validates :map_zoom_level, numericality: { only_integer: true }
  validates_attachment :leader_image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..5.megabytes }
  validates_attachment :flag_image,
    content_type: { content_type: ["image/jpeg", "image/png"] },
    size: { in: 0..5.megabytes }


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
