# Ultimate Uploader III

Same app as the previous challenge, only this time the secret isn't in the
session.

## Setup

~~~bash
$ bundle install
$ rails server
~~~

## Secret location

The application will display the secret prominently if your session hash
contains `:show_secret => true`. Craft, encrypt and sign a session cookie with
this payload and make the application load your session to obtain the secret.
