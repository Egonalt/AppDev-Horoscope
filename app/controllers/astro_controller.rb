

class AstroController < ApplicationController
  def home
    render({ :template => "astro_templates/home" })
  end
  def show
    @astro_details = AstroApiService.fetch_astro_details(
      params[:day], 
      params[:month], 
      params[:year], 
      params[:hour], 
      params[:min], 
      params[:name], 
      params[:lat], 
      params[:lon], 
      params[:tzone]
    )
    render 'astro_templates/show'
  end
end
