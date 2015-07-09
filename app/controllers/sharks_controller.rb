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
   @shark = Unirest.post("http://localhost:3000/v1/sharks.json",
              headers:{ "Accept" => "application/json" }, 
              parameters:{common_name: params[:common_name], latin_name: params[:latin_name], habitat_range: params[:habitat_range], attacks_on_humans: params[:attacks_on_humans]}).body
   p @shark
    redirect_to "/sharks/#{@shark["id"]}"
  end

  def edit
    @shark = Unirest.get("http://localhost:3000/v1/sharks/#{params[:id]}.json").body
  end

  def update
    @shark = Unirest.patch("http://localhost:3000/v1/sharks/#{params[:id]}.json", headers:{ "Accept" => "application/json" }, parameters:{common_name: params[:common_name], latin_name: params[:latin_name], habitat_range: params[:habitat_range], attacks_on_humans: params[:attacks_on_humans]}).body
    redirect_to "/sharks/#{params[:id]}"
  end

  def destroy
    shark = Shark.find(params[:id])
    shark.destroy
    redirect_to "/"
  end
end
