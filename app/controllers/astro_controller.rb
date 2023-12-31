class AstroController < ApplicationController
  def home
    session[:random_ticker] = random_stock_ticker

    render({ :template => "astro_templates/home" })
  end

  def show
    response.headers["Cache-Control"] = "no-cache, no-store"
    Rails.logger.info "Received parameters: #{params.inspect}"
    if params[:day].present? && params[:month].present? && params[:year].present?

      session[:last_astro_input] = params.to_unsafe_h


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
    elsif session[:last_astro_input]

      last_input = session[:last_astro_input]
      @astro_details = AstroApiService.fetch_astro_details(
        last_input["day"], 
        last_input["month"], 
        last_input["year"], 
        last_input["hour"], 
        last_input["min"], 
        last_input["name"], 
        last_input["lat"], 
        last_input["lon"], 
        last_input["tzone"]
      )
    else

      redirect_to astro_home_path, alert: 'Please provide astrological details for analysis.'
      return
    end
    @random_ticker = session[:random_ticker] || "N/A"
    if current_user  
      current_user.user_stocks.create(stock_tickers: @random_ticker)
    end

    render 'astro_templates/show'
  end

  private

  def random_stock_ticker
    tickers = File.readlines(Rails.root.join('lib', 'assets', 'stock_tickers.txt')).map(&:strip)
    selected_tickers = tickers.sample(5) 
    Rails.logger.info "Selected Stock Tickers: #{selected_tickers.join(', ')}"
    selected_tickers.join(', ')
  rescue StandardError => e
    Rails.logger.error "Error reading stock tickers: #{e.message}"
    "N/A"
  end
end
