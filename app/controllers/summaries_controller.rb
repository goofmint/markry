class SummariesController < ApplicationController
  def index
    @summaries = Summary.where(:enable_flag => true).order("publish_at desc").page(params[:page]).per(20)
  end

  def show
    @summary = Summary.where(:id => params[:id]).first
  end
end
