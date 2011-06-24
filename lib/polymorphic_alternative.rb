require 'active_model'
require 'active_support/core_ext/class'

module PolymorphicAlternative
  autoload :Relations,       "polymorphic_alternative/relations"
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend PolymorphicAlternative::Relations
end