class Account < ApplicationRecord
    has_many :transactions
    has_many :incrementors
end
