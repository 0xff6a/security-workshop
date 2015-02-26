# Project Amazing

Project Amazing is a project management application, how exciting! Here you'll
be compromising the session management of the application to bypass
authentication. This one is a little trickier and will probably take more than
an hour to string into a semi-automated attack.

## Setup Instructions

First install pahantomjs. This will differ from one OS to the next, so find the
instructions from google. Once phantomjs is installed, continue with the
following setup instructions.

Then:

~~~bash
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake setup
$ foreman start
~~~

**IMPORTANT**: Note that we use `foreman start` instead of `rails server` for
this application. A second process will simulate an admin user logging in to
the application every five seconds.

## Secret Location

The secret is prominantly displayed in the admin section of the application.
Gain access to the admin section and you'll find the secret.
