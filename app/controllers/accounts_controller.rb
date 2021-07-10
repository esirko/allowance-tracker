class AccountsController < ApplicationController

    def index
        @accounts = Account.all
    end
    
    def show
        @account = Account.find(params[:id])
        @transactions = @account.transactions.order(:timestamp)
        @incrementors = @account.incrementors.order(:effectivedate)

        start_date = Date.today
        if @transactions.any?
            start_date = @transactions.first.timestamp.to_date
        end
        if @incrementors.any?
            start_date = @incrementors.first.effectivedate.to_date
        end

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

            withholdIncrementToday = false
            while it < @transactions.size && @transactions[it].timestamp <= d
                if @transactions[it].withholdIncrementToday?
                    if !withholdIncrementToday
                        # Note: the transaction's amount is ignored
                        @virtual_transactions.push(Transaction.new(account_id: @account.id, timestamp: @transactions[it].timestamp, amount: 0.0, description: '[Withholding allowance] ' + @transactions[it].description, balance: balance))
                        withholdIncrementToday = true
                    else
                        puts("Unexpected: Two withholds on the same day... ignoring the second one")
                    end
                else
                    balance += @transactions[it].amount
                    @virtual_transactions.push(Transaction.new(account_id: @account.id, timestamp: @transactions[it].timestamp, amount: @transactions[it].amount, description: @transactions[it].description, balance: balance))
                end
                it += 1
            end

            if !withholdIncrementToday
                increment = ii > 0 ? @incrementors[ii - 1].amountperday : 0
                if increment != 0
                    balance += increment
                    @virtual_transactions.push(Transaction.new(account_id: @account, timestamp: d, amount: increment, description: "Allowance", balance: balance))
                end
            end

            id += 1
        end

    end
    
end
