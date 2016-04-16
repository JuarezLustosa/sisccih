class Material < ActiveRecord::Base
  validates :description, presence: true
  validates :description, uniqueness: true, on: :create

  ransacker :id do
    Arel.sql("to_char(id, '9999999')")
  end
end
