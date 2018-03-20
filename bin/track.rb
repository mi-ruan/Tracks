class Track
  attr_reader :name, :artist, :album

  def self.all
    @tracks ||= []
  end

  def initialize(params = {})
    params ||= {}
    @name, @artist, @album = params["name"], params["artist"], params["album"]
  end

  def errors
    @errors ||= []
  end

  def valid?
    unless @name.present?
      errors << "Name can't be blank"
      return false
    end

    unless @artist.present?
      errors << "Artist can't be blank"
      return false
    end

    unless @album.present?
      errors << "Album can't be blank"
      return false
    end
    true
  end

  def save
    return false unless valid?
    Track.all << self
    true
  end
end
