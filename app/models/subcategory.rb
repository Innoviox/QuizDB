class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :tossups
  has_many :bonuses, class_name: Bonus
  has_many :bonus_parts, through: :bonuses

  default_scope { order(name: :asc) }

  validates :name, uniqueness: true

end
