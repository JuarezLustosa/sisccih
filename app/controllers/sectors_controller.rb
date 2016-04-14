class SectorsController < ApplicationController
  def index
    @q = Sector.search(params[:q])
    @sectors = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10 )
    respond_with @sectors
  end

  def new
    @sector = Sector.new
  end

  def create
    @sector = Sector.new(sector_params)
    @sector.save
    respond_with @sector, location: sectors_path
  end

  def edit
    @sector = Sector.find(params[:id])
  end

  def update
    @sector = Sector.find(params[:id])

    @sector.update_attributes(sector_params)
    respond_with @sector, location: sectors_path
  end

  def destroy
    @sector = Sector.find(params[:id])
    @sector.destroy
    respond_with @sector
  end

  private

  def sector_params
    params.require(:sector).permit(:name)
  end
end
