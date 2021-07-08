class AccountsController < ApplicationController
    def index
        @accounts = Account.all
    end
    
    def show
        @account = Account.find(params[:id])
        @transactions = @account.transactions.order(:timestamp)
        @incrementors = @account.incrementors.order(:effectivedate)

        start_date = [@transactions.first.timestamp.to_date, @incrementors.first.effectivedate.to_date].min
        end_date = Date.today + 1

        @virtual_transactions = Array.new
        ii = 0 # incrementor iterator
        it = 0 # transaction iterator
        id = 0 # date iterator
        balance = 0.0

        for d in start_date..end_date
            while ii < @incrementors.size && @incrementors[ii].effectivedate <= d
                ii += 1
            end

            while it < @transactions.size && @transactions[it].timestamp <= d
                balance += @transactions[it].amount
                @virtual_transactions.push(Transaction.new(account_id: @account.id, timestamp: @transactions[it].timestamp, amount: @transactions[it].amount, description: @transactions[it].description, balance: balance))
                it += 1
            end

            increment = ii > 0 ? @incrementors[ii - 1].amountperday : 0
            if increment != 0
                balance += increment
                @virtual_transactions.push(Transaction.new(account_id: @account, timestamp: d, amount: increment, description: "Allowance", balance: balance))
            end

            id += 1
        end

    end
    
end
