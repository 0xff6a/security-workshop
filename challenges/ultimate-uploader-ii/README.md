# Ultimate Uploader II

The exact same app as in the previous challenge, only this time the secret
isn't the `secret_token.rb` file.

## Setup

~~~bash
$ bundle install
$ rails server
~~~

## Secret location

The secret is set as a value in the session. Decrypt the session to obtain the
secret.
