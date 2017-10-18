class SearchController < ApplicationController
  before_action :authenticate_user!

  def indicators
  end

  def index
    # IOC search page handler
    if params[:search][0].to_s.length < 1
      redirect_to search_indicators_path
    else
      query = params[:search][0]
      @result = search(query)
    end
  end

  def search(search)
    # search function
    @results = Element.where("value like ?", "%#{search}%").page params[:page]
    if @results.blank?
      redirect_to search_indicators_path, :alert => "No results"
    end
  end

  def delete_iocs
    # function to remove IOCs from the db
    data = params[:ioc]
    ioc = Element.find_by(:id => data)
    begin
      ioc.destroy
    rescue
      redirect_to :back, :alert => "Error: IOC was not deleted!"
    end
    redirect_to :back, :notice => "IOC successfully deleted!"
  end
end
