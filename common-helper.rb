def load_provider(type)
  result = nil
  if type == Models::PROVIDER_YOUTUBE
    return LibYoutube.new
  end
end
