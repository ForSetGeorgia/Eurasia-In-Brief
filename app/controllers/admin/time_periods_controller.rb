class Admin::TimePeriodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_time_period, only: [:show, :edit, :update, :destroy]
  before_action :set_variables, only: [:new, :create, :edit, :update]
  authorize_resource

  # GET /admin/time_periods
  # GET /admin/time_periods.json
  def index
    @time_periods = TimePeriod.sorted
  end

  # GET /admin/time_periods/1
  # GET /admin/time_periods/1.json
  def show
  end

  # GET /admin/time_periods/new
  def new
    @time_period = TimePeriod.new
  end

  # GET /admin/time_periods/1/edit
  def edit
  end

  # POST /admin/time_periods
  # POST /admin/time_periods.json
  def create
    @time_period = TimePeriod.new(time_period_params)

    respond_to do |format|
      if @time_period.save
        format.html { redirect_to admin_time_periods_path, notice: t('shared.msgs.success_created',
                            obj: t('activerecord.models.time_period', count: 1))}
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /admin/time_periods/1
  # PATCH/PUT /admin/time_periods/1.json
  def update
    respond_to do |format|
      if @time_period.update(time_period_params)
        format.html { redirect_to admin_time_periods_path, notice: t('shared.msgs.success_updated',
                            obj: t('activerecord.models.time_period', count: 1))}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /admin/time_periods/1
  # DELETE /admin/time_periods/1.json
  def destroy
    @time_period.destroy
    respond_to do |format|
      format.html { redirect_to admin_time_periods_url, notice:  t('shared.msgs.success_destroyed',
                              obj: t('activerecord.models.time_period', count: 1))}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_period
      @time_period = TimePeriod.friendly.find(params[:id])
    end

    # set variables for the form
    def set_variables
      @max_order = TimePeriod.max_order
      @max_order = 0 if @max_order.nil?
      # increase the max order by 1 to be used for the next time period
      @max_order += 1
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_period_params
      permitted = TimePeriod.globalize_attribute_names + [:order, :is_published]
      params.require(:time_period).permit(*permitted)
    end
end
