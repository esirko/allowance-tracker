# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Misc notes

I generated the Account and Transaction models out of order, so Transaction was missing a reference to account. So here's how to fix that.
https://stackoverflow.com/questions/4338973/adding-a-model-reference-to-existing-rails-model/16354869#16354869
```
rails generate migration AddAccountRefToTransaction account:references
```
