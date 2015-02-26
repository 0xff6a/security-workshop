# Ultimate Uploader IV

Same app as the previous challenge, only this time the secret is only
available from within the application code.

## Setup

~~~bash
$ bundle install
$ rails server
~~~

## Secret location

In this challenge, you're going to need to trick the application into
running some code. The code `Secret.get` when run in the web application
process will return the secret. Run that code and get the secret out of
the application.
