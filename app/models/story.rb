class Story < ActiveRecord::Base

  #######################
  ## ASSOCIATIONS
  belongs_to :time_period
  belongs_to :country

  #######################
  ## VALIDATIONS

  validates :country_id, :time_period_id, :content, :locale, :title, presence: :true
  validates :locale, inclusion: { in: I18n.available_locales.map{|x| x.to_s} }
  validates :link, :url => true, unless: Proc.new { |x| x.link.blank? }

  #######################
  ## SCOPES
  def self.with_time_period_translations
    includes(time_period: :translations)
  end

  def self.sort_time_period
    order("time_periods.order desc")
  end

  def self.with_country_translations
    includes(country: :translations)
  end

  def self.by_locale(locale)
    where(locale: locale)
  end

  def self.by_time_period(time_period_id)
    where(time_period_id: time_period_id)
  end

  def self.by_country(country_id)
    where(country_id: country_id)
  end

end
