class Story < ActiveRecord::Base

  #######################
  ## ASSOCIATIONS
  belongs_to :time_period
  belongs_to :country

  #######################
  ## VALIDATIONS

  validates :country_id, :time_period_id, :content, :locale, :title, presence: :true
  validates :locale, inclusion: { in: I18n.available_locales.map{|x| x.to_s} }

  #######################
  ## SCOPES
  def self.by_locale(locale)
    where(locale: locale)
  end

  def self.with_translations
    includes(time_period: :translations, country: :translations)
  end

end
