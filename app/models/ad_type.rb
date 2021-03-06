class AdType < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :abbrev
  validates_uniqueness_of :name
  validates_uniqueness_of :abbrev

  def video?
    ['NSV', 'SVD'].include?(abbrev)
  end

end
