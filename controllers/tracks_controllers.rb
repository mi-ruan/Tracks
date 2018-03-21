require_relative '../lib/controller_base'
require_relative '../models/track_model'

class TracksController < ControllerBase

  def create
    @track = Track.new(params["track"])
    if @track.save
      flash[:notice] = "Added track successfully"
      redirect_to "/tracks"
    else
      flash.now[:errors] = @track.errors
      render :new
    end
  end

  def index
    @tracks = Track.all
    render :index
  end

  def new
    @track = Track.new
    render :new
  end

end
