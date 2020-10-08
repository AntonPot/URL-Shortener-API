# README

URL Shortener generates short URLs.
It allows users to sign in and create shorter versions of URLs which will then redirect
to original destination.
Users with account can download link usage data in CSV file.

## Setup
Postgres:
```
brew install postgresql
brew services start postgresql
```

Yarn:
```
brew install yarn
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
rails s
```

Open [Localhost:3000](http://localhost:3000)
