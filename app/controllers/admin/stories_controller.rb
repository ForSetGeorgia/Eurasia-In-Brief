class Admin::StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]
  authorize_resource

  # GET /admin/stories
  # GET /admin/stories.json
  def index
    @stories = Story.with_translations
  end

  # GET /admin/stories/1
  # GET /admin/stories/1.json
  def show
  end

  # GET /admin/stories/new
  def new
    @story = Story.new
  end

  # GET /admin/stories/1/edit
  def edit
  end

  # POST /admin/stories
  # POST /admin/stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to [:admin,@story], notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.story', count: 1))}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/stories/1
  # PATCH/PUT /admin/stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to [:admin,@story], notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.story', count: 1))}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/stories/1
  # DELETE /admin/stories/1.json
  def destroy
    @story.destroy
    respond_to do |format|
      format.html { redirect_to admin_stories_url, notice:  t('shared.msgs.success_destroyed',
                              obj: t('activerecord.models.story', count: 1))}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params[:id])
    end

    # set variables for the form
    def set_variables
      @countries = Country.sorted
      @time_periods = TimePeriod.sorted

      @locales = []
      I18n.available_locales.sort.each do |locale|
        @locales << [I18n.t("shared.locale.long.#{locale}"), I18n.t("shared.locale.short.#{locale}").downcase]
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def story_params
      permitted = [:locale, :content, :link, :time_period_id, :country_id]
      params.require(:story).permit(*permitted)
    end
end
