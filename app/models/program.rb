class Program < ApplicationRecord
  belongs_to :network
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :abbrev
  validates_uniqueness_of :abbrev
  validates_presence_of :network
end
