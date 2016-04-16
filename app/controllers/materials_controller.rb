class MaterialsController < ApplicationController
  def index
    @q = Material.search(params[:q])
    @materials = @q.result(distinct: true).paginate(:page => params[:page], :per_page => 10 )
    respond_with @materials
  end

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.save
    respond_with @material, location: materials_path
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])

    @material.update_attributes(material_params)
    respond_with @material, location: materials_path
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    respond_with @material
  end

  private

  def material_params
    params.require(:material).permit(:description)
  end
end

