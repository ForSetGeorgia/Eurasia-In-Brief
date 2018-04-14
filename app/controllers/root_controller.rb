# Non-resource pages
class RootController < ApplicationController
  def index
    # get time periods
    @time_periods = TimePeriod.published.sorted

    if @time_periods.present?
      # determine which time period to show
      # - if param does not exist, get the current one
      @time_period = nil
      if params[:time_period].present?
        @time_period = @time_periods.select{|x| x.slug == params[:time_period]}.first
      end
      # if no period was found, get the most recent
      @time_period = @time_periods.first if @time_period.nil?

      # get stories
      if @time_period.present?
        @stories = Story.by_locale(I18n.locale).by_time_period(@time_period.id)
        @countries = Country.sorted

        timePeriodIds = @time_periods.pluck(:id)
        timePeriodIndex = timePeriodIds.find_index(@time_period.id)

        before = nil
        after = nil
        if timePeriodIndex > 0
          before = @time_periods[timePeriodIndex - 1]
        end
        if timePeriodIndex + 1 < timePeriodIds.length
          after = @time_periods[timePeriodIndex + 1]
        end

        @periods = [before, @time_period, after]
      end
    end
  end

  def country
    @country = Country.friendly.find(params[:id])

    if @country.present?
      @stories = Story.with_time_period_translations.by_locale(I18n.locale).by_country(@country.id).sort_time_period

      @countries = Country.sorted


      countryIds = @countries.pluck(:id)
      countryIndex = countryIds.find_index(@country.id)
      @next_country = nil
      if countryIndex + 1 < countryIds.length
        @next_country = @countries[countryIndex + 1]
      else
        firstCountry = @countries.first()
        if @country != firstCountry
          @next_country = firstCountry
        end
      end


      @add_map_assets = true
      gon.mapbox_token = ENV['MAPBOX_TOKEN']
      gon.mapbox_url = ENV['MAPBOX_URL']
    else
      redirect_to root_path,
                alert: t('shared.msgs.does_not_exist')
    end

  end

  def about
  end
end
