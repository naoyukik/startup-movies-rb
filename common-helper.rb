def load_provider(type)
  object_hash = {
    Models::PROVIDER_YOUTUBE => LibYoutube.new,
    Models::PROVIDER_VIMEO => LibVimeo.new
  }
  return object_hash[type]

  # if type == Models::PROVIDER_YOUTUBE
  #   return LibYoutube.new
  # end
end
