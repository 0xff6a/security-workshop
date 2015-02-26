# Payroll Buddy

This application helps organisations manage payroll. Each user belongs to an
organisation and each organisation is managed by 'manager' users. You'll be
bypassing the access control functionality of the app to obtain the secret.

This should take you around **30-60 minutes** to complete.

## Setup Instructions

~~~bash
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake setup
$ rails server
~~~

## Secret Location

Set the salary of the user with the following details to 25000

* Name: 'Clark Kent'
* Email: 'clark.kent@gmail.com'
* Organisation name: 'The Daily Planet'

Once you've done that, the application will display the secret on every page.
