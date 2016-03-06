class SectionsController < ApplicationController
  layout "admin"
  def index
    @sections = Section.all
  end

  def new
    @section = Section.new(:name => "Default")
  end

  def show
    @section = Section.find(params[:id])
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created!"
      redirect_to(:action => 'index')
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Update section!"
      redirect_to(:action => 'show', :id => @section.id)
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id]).destroy
    flash[:notice] = "Deleted #{@section.name} seccessully!!"
    redirect_to(:action => "index")
  end

  private

  def section_params
    params.require(:section).permit(:name,:position,:visible,:content,:content_type,:page_id)
  end
end
