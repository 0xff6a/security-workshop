# Todo List II

The same todo list application, only this time more cryptography.

## Setup Instructions

~~~bash
$ bundle install
$ bundle exec rake db:migrate
$ bundle exec rake setup
$ rails server
~~~

## Secret Location

The secret is once again located on the tasks index screen of the user with
email address `j.osterman@watchmen.net`. The same strategy you used to get the
secret in the previous exercise will work here (i.e. craft a password reset
token, change the users password, get to their tasks index screen).

The data in the password reset token is in the same format as before, only this
time it's encrypted using AES in [ECB][ecb] mode with a 128-bit block size
before being base64 encoded. The key used for encryption is the same for every
password reset token.

[ecb]: https://en.wikipedia.org/wiki/Block_cipher_mode_of_operation#Electronic_codebook_.28ECB.29

Some quick definitions:

* **Plaintext** is the regular, human-readable text that you want to keep secret.
* **Ciphertext** is what you get once you encrypt plaintext.

AES is a form of *symmetric* encryption, i.e. the same key is used for both
encryption and decryption. In this exercise, the key is kept on the server and
there is no way of attaining it.

AES in ECB mode works by taking one block of plaintext at a time and encrypting
it with the key. This means that the plaintext block 'YELLOW SUBMARINE' (exactly
one block-size, 128 bits i.e. 16 bytes) always encrypts to the same ciphertext
under a given key.

![ECB Mode](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d6/ECB_encryption.svg/1000px-ECB_encryption.svg.png)

In this challenge the encrypted password reset token is encoded with
`Base64.urlsafe_encode64` for transport.
