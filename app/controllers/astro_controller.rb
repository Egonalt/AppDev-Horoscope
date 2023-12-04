class AstroController < ApplicationController
  def home
    session[:random_ticker] = random_stock_ticker

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
    @random_ticker = session[:random_ticker] || "N/A"

    render 'astro_templates/show'
  end

  private

  def random_stock_ticker
    tickers = File.readlines(Rails.root.join('lib', 'assets', 'stock_tickers.txt'))
    selected_ticker = tickers.sample.strip
    Rails.logger.info "Selected Stock Ticker: #{selected_ticker}"
    selected_ticker
  rescue StandardError => e
    Rails.logger.error "Error reading stock tickers: #{e.message}"
    "N/A"
  end
end
