# Rails Security Challenges

*Note: These challenges are currently in beta. The package you've purchased
entitles you to all future product updates. You will likely be receiving
updates and corrections based on feedback over the coming months*.

There are ten challenges. Each one is a Rails application that you run locally
and attempt to compromise. 

In each challenge, your task is to obtain a *secret*. The secret is a block of
random base64 encoded data. Obtaining it will require that you bypass a
security mechanism of the application.

You can confirm that you have the secret by diffing against the `secret` file
in the root directory of each challenge app. You can also compare your solution
to the `exploit` script for each challenge, also in the root directory.

Each challenge has a README.md file detailing setup instructions and directions
for obtaining the secret.

While the code for each challenge belongs to you to do with as you please, much
of the fun of the challenges comes from probing the applications for
vulnerabilities as though they were running on remote servers. You'll probably
learn more from the exercises if you avoid reading the code or observing log
output until you break them.

Some challenges will require that you *automate* your exploit. You're welcome
to do this however you see fit, though all the model exploits use the
`mechanize` HTTP automation library or simply `net/http`.

## Challenge order

Below is a list in of the challenges in the order they're meant to be
completed, along with a difficulty rating (from easy => diabolical) for each
challenge:

* [easy]       secret-keeper
* [medium]     weight-tracker
* [medium]     payroll-buddy
* [hard]       project-amazing
* [medium]     todo-list-i
* [diabolical] todo-list-ii
* [medium]     ultimate-uploader-i 
* [medium]     ultimate-uploader-ii
* [hard]       ultimate-uploader-iii 
* [diabolical] ultimate-uploader-iv

The difficulty levels are intended as a rough guide based on observing students
work through the challenges during the in-person workshop. Don't worry too much
if they don't match up to your experiences of the challenges.

## Hints

Each challenge has a `hints/` directory with files `1.md`, `2.md` and `3.md`.

The first hint (`1.md`) will tell you the general area to look for finding the
vulnerability.

The second hint (`2.md`) will attempt to make it more obvious and perhaps give
you a clue to devising a plan of attack.

The third hint (`3.md`) will spell out exactly what to do to exploit the
application.

I recommend that you give yourself ten to twenty minutes to discover the
vulnerabilities on your own before consulting the hints.

You'd be surprised what you come up with if you spend just a *little* bit more
time experimenting, so don't be too quick to consult these hints.

## Hacking tools

Here are a few tools that will come in handy while probing and exploiting the
challenge web apps...

### Web inspector: Modify form fields

When you want to see what happens when you send fields other than those
expected to a form action, instead of writing a script or curl invocation to
do it for you, you can use the Chrome Web Inspector (or alternative for your
browser) to do it easily.

Right click on any given field in a form and click on the "Inspect Element"
option.

You can then modify the `name` attribute of the form elements to change the
name of the parameter being sent to the server in the POST request that
submitting the form sends to the server. Double click on the attribute name in
the inspector and you should be able to modify it.

If you submit the form then you'll be sending the fields with the new name you
typed in rather than the fields that the form originally presented to you. You
can also add arbitrary HTML elements to the form and submit whatever
additional fields you deem fit.

### Web inspector: Copy as cURL

The web inspector also has a neat little feature that allows you to copy the
curl invocation equivalent to a given request that a browser has made into
your copy-paste buffer. Just right click the request in the network tab and
select "Copy as cURL".

You can then paste that directly into your terminal to execute. It would
probably be easier to work with if you pasted into your text editor of choice
and modified it as a bash script.

### Requestbin for analyzing HTTP requests

[Requestbin](http://requestb.in/) is a service that generates a temporary URL
for you and then allow you to analyze any request made to that URL, including
the method, headers and any data in the request body. This is useful if you
don't have direct control over a users actions but can trick them into a
visiting a URL you can monitor in order to steal some information from them.

### Modifying browser cookies

Browser plugins like [Edit This Cookie][etc] allow you to read, delete, edit
and create new cookies for your browser session with a given host. If for
whatever reason we wanted to steal and paste in another users cookie, a plugin
like this is what we'd use to act as though that cookie were our own.

[etc]: https://chrome.google.com/webstore/detail/edit-this-cookie/fngmhnnpilhplaeedifhccceomclgfbg?hl=en

### Mechanize

Mechanize is a simple ruby library that allows you to automate interactions
with web sites. Here's a quick cheat sheet showing how to do various actions
with it: [https://gist.github.com/Najaf/7309910](https://gist.github.com/Najaf/7309910)

## Get started

To start the challenges, cd into the `secret-keeper` directory, open README.md,
follow the setup instructions and start hacking!

## Contact details

If at any stage you get stuck or would like feedback on your solutions, get in
touch at ali@happybearsoftware.com. I'm looking forward to hearing from you.

Good hunting,

-Ali
