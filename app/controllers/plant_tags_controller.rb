class PlantTagsController < ApplicationController
  def new
    @plant = Plant.find(params[:plant_id])
    @plant_tag = PlantTag.new
  end

  # Method one, that in hindsight is a bit unneccessary
  def create
    @plant = Plant.find(params[:plant_id])
    tags = Tag.where(id: params[:plant_tag][:tag])
    valid_tag = true

    tags.each do |t|
      @plant_tag = PlantTag.new
      @plant_tag.plant = @plant
      @plant_tag.tag = t
      if !@plant_tag.save
        valid_tag = false
      end
    end

    if valid_tag
      redirect_to garden_path(@plant.garden)
    else
      render :new
    end
  end

  # Method two, that in hindsight is cleaner
  def create
    @plant = Plant.find(params[:plant_id])
    if params[:plant_tag][:tag].present?
      tags = Tag.where(id: params[:plant_tag][:tag])
      tags.each do |t|
        @plant_tag = PlantTag.new
        @plant_tag.plant = @plant
        @plant_tag.tag = t
        @plant_tag.save
      end
      redirect_to garden_path(@plant.garden)
    else
      render :new
    end
  end


end
