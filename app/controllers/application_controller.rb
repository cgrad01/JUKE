class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  helper_method :current_user, :logged_in?
  LOCAL_LOGIN = 'LOCAL_LOGIN'

  before_action :require_login

  def require_login
    unless logged_in?
      flash[:error] = "Log in to access JUKE"
      redirect_to root_path
    end
  end

  def current_user
    current_user ||= User.find_by(id: session[:user_id])
  end
  # if i want to use this in view we should put this in helper

  def logged_in?
    !!current_user
  end

  #This should be removed when jon is ready
  def spotify_post(endpoint_url, hash_of_params)
    uri = URI(endpoint_url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri)
    request.set_form_data(hash_of_params)
    response = http.request(request)
  end
  ##########


  #This should be removed when jon is ready
  def search_url(query_array, type)
    altered_query = query_array.split(" ").join("%20")
    "https://api.spotify.com/v1/search?q=#{altered_query}&limit=20&type=#{type}"
  end
  ############

  #This should be removed when jon is ready
  def get_setlist_tracks(setlist)
    json = SpotifyPlaylistGetter.new(session[:token], setlist: setlist).get
    parsed = JSON.parse(json.body)
    t_array = parsed["tracks"]["items"]

    tracks = t_array.map do |t|
      artist_list = []
      t["track"]["artists"].each { |artist| artist_list << artist["name"] }
      {
        title: t["track"]["name"],
        song_spotify_url: t["track"]["href"],
        album: t["track"]["album"]["name"],
        artist: artist_list.join(", ")
      }
    end

    tracks
  end
  ################

  def parse_emails(string)
    string.strip.split(",")
  end

  protect_from_forgery with: :exception
end
