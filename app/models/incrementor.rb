class Incrementor < ApplicationRecord
  belongs_to :account

  validates :amountperday, presence: true
  validates :effectivedate, timeliness: {type: :date}
end
