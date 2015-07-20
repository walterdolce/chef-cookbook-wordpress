if defined?(ChefSpec)
  ChefSpec.define_matcher(:archive)

  def extract_archive(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:archive, :extract, resource)
  end
end
