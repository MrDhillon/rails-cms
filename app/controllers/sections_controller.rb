class SectionsController < ApplicationController
  layout "admin"
  def index
    @sections = Section.all
  end

  def new
    @section = Section.new(:name => "Default")
    @pages = Page.order('position ASC')
    @section_count = Section.count + 1
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
      @pages = Page.order('position ASC')
      @section_count = Section.count + 1
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
    @pages = Page.order('position ASC')
    @section_count = Section.count
  end

  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(section_params)
      flash[:notice] = "Update section!"
      redirect_to(:action => 'show', :id => @section.id)
    else
      @pages = Page.order('position ASC')
      @section_count = Section.count
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
