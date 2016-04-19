class UnitsController < ApplicationController
  def index
    @q = Unit.search(params[:q])
    @units = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10 )
    respond_with @units
  end

  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.save
    respond_with @unit, location: units_path
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])

    @unit.update_attributes(unit_params)
    respond_with @unit, location: units_path
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    respond_with @unit
  end

  private

  def unit_params
    params.require(:unit).permit(:description)
  end
end
