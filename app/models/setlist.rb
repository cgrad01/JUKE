class Setlist < ActiveRecord::Base
  belongs_to :host, class_name: "User", foreign_key: :user_id
  has_many :setlist_songs
  has_many :songs, through: :setlist_songs
  has_many :guest_setlists
  has_many :guests, through: :guest_setlists, source: :user

  validates_presence_of :host, :name, :invite_code, :list_spotify_url

  def spotify_id
    list_spotify_url.split("/").last
  end

  def sort_by_votecount(list_status = nil)
    s_songs(list_status).sort_by { |setlist_song| -1 * setlist_song.count_vote_total }
  end

  private

  def s_songs(list_status)
    if list_status
      setlist_songs.where(list_status: list_status)
    else
      setlist_songs
    end
  end
end
