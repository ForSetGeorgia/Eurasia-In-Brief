class Admin::CountriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]
  authorize_resource

  # GET /admin/countries
  # GET /admin/countries.json
  def index
    @countries = Country.sorted
  end

  # GET /admin/countries/1
  # GET /admin/countries/1.json
  def show
  end

  # GET /admin/countries/new
  def new
    @country = Country.new
  end

  # GET /admin/countries/1/edit
  def edit
  end

  # POST /admin/countries
  # POST /admin/countries.json
  def create
    @country = Country.new(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to [:admin,@country], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.country', count: 1))}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/countries/1
  # PATCH/PUT /admin/countries/1.json
  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to [:admin,@country], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.country', count: 1))}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/countries/1
  # DELETE /admin/countries/1.json
  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to admin_countries_url, notice:  t('shared.msgs.success_destroyed',
                              obj: t('activerecord.models.country', count: 1))}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.friendly.find(params[:id])
    end

    # set variables for the form
    def set_variables
      @freedom_house_values = []
      I18n.t("shared.common.freedom_house").each do |key, value|
        @freedom_house_values << [value, key]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def country_params
      permitted = Country.globalize_attribute_names +
        [
          :lat, :lon, :map_zoom_level, :leader_image, :flag_image, :flag_image2, :area, :population,
          :freedom_house_index, :freedom_house_url, :ti_index_score, :ti_index_rank, :ti_url
        ]
      params.require(:country).permit(*permitted)
    end
end
