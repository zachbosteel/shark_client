class SharksController < ApplicationController

  def index
    @sharks = Shark.all
  end
  
  def show
    @shark = Shark.find(params[:id])
  end
  
  def new
  end

  def create
   @shark = Unirest.post("#{ENV['API_BASE_URL']}/sharks.json",
              headers:{ "Accept" => "#{ENV['JSON']}", "Authorization" => "#{ENV['AUTHORIZATION']}", "X-User-Email" => "#{ENV['X_USER_EMAIL']}"}, 
              parameters:{common_name: params[:common_name], latin_name: params[:latin_name], habitat_range: params[:habitat_range], attacks_on_humans: params[:attacks_on_humans]}).body
   p @shark
    redirect_to "#{ENV['API_BASE_URL']}/sharks/#{@shark["id"]}"
  end

  def edit
    @shark = Unirest.get("#{ENV['API_BASE_URL']}/sharks/#{params[:id]}.json").body
  end

  def update
    @shark = Unirest.patch("#{ENV['API_BASE_URL']}/sharks/#{params[:id]}.json", headers:{ "Accept" => "#{ENV['JSON']}", "Authorization" => "#{ENV['AUTHORIZATION']}", "X-User-Email" => "#{ENV['X_USER_EMAIL']}"}, parameters:{common_name: params[:common_name], latin_name: params[:latin_name], habitat_range: params[:habitat_range], attacks_on_humans: params[:attacks_on_humans]}).body
    redirect_to "#{ENV['API_BASE_URL']}/sharks/#{params[:id]}"
  end

  def destroy
    shark = Shark.find(params[:id])
    shark.destroy
    redirect_to "#{ENV['API_BASE_URL']}/"
  end
end
