# README

URL Shortener generates short URLs.
It allows users to sign in and create shorter versions of URLs which will then redirect
to original destination.
Users with account can download link usage data in CSV file.

Front-end is written in React and available on [here](https://github.com/AntonPot/URL-Shortener-React)

## Setup
Postgres:
```
brew install postgresql
brew services start postgresql
```

Install dependencies:
```
bundle install
```

Create DB:
```
rake db:create db:migrate db:seed
```

## Run
```
rails s -p 3001
```

Open [Localhost:3001](http://localhost:3001)
