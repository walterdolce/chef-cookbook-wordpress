provides :archive
provides :package
provides :directory
provides :execute
provides :file
provides :template

actions :extract
default_action :extract
attribute :archive,
  :kind_of => String,
  :name_attribute => true,
  :required => true

