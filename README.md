# allowance-tracker

Our family's allowance policy is that the kids get a dollar a day by default, but allowance is withheld for bad behavior. This app enables easy updating of transactions as well as allowing the kids to self-check how much money is in their account.

This is my first rails project so I'm using it to learn rails too.

# To deploy

You can deploy locally for testing:
```
bin/rails server
```

I use heroku to deploy to the public cloud:
```
git push heroku main
```

After a DB migration, do
```
heroku run rails db:migrate
heroku restart
```

The restart seems to be important.. until you do that things are not in a good state.

You can also deploy locally via heroku:
```
heroku local
```

# Getting started
You need to add an _account_ for each kid. There is no UI interface for this, so here's how to do it:
```
bin/rails console (or heroku run rails console)
account = Account.new(name:'Remi')
account.save
```

You also need to add an _admin user_ so that you can edit transactions. Anyone who knows the login/password will be able to edit the transactions, so it's important the kids don't know it.
```
user = User.new(login:'x', password:'xxx',active:true,approved:true,confirmed:true)
user.save
```
If the transaction rollbacks, you can do `user.errors` to see what's wrong.

# How to use

Once you access the app, go to the kid's account. Sign in with the admin credentials to access the "New transaction" and "New incrementor" controls. First, add a new incrementor. Give it a start date, an increment per day (e.g., `1`), and a comment. That will be the default allowance given every day.

If you ever want to boost allowance, or deduct allowance when the kids decide to buy something, add a new transaction. 

But if you want to _withhold_ allowance, add a new transaction and check the box for "withhold increment today." In this case the `amount` is ignored. 

There is an intentional subtle difference between withholding the increment for a day and simply having a transaction for -$1 in the way it shows up in the "virtual transactions" list. I want the kids to understand that allowance is _withheld_ as a consequence for bad behavior, instead of earning an allowance by default which is then canceled out with a _penalty_ deduction.


# Misc notes

I generated the Account and Transaction models out of order, so Transaction was missing a reference to account. So here's how to fix that.
https://stackoverflow.com/questions/4338973/adding-a-model-reference-to-existing-rails-model/16354869#16354869
```
rails generate migration AddAccountRefToTransaction account:references
```


