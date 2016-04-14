class Sector < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true, on: :create

  ransacker :id do
    Arel.sql("to_char(id, '9999999')")
  end
end
