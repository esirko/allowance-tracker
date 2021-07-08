class Transaction < ApplicationRecord
    belongs_to :account

    validates :amount, presence: true
    validates :description, presence: true
    validates :timestamp, timeliness: {type: :date}

    attr_accessor :balance
end


