# config/initializers/ransack.rb
#
# Custom ransack predicate to simplify query for date range
#
# See lib/ransack.rb in ransack gem
# See wiki https://github.com/activerecord-hackery/ransack/wiki/Custom-Predicates
Ransack::Adapters::ActiveRecord::Base.class_eval('remove_method :search')
