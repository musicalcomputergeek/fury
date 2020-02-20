fury
====

A bot made with the twitter gem that composes tweets or initiates a stream of spam tweets from the command line, all in an effort to unleash my fury at any given time on any given twitter account.

Find my website development work at https://timothyreavis.io/


instructions
====

First, make sure you have the twitter gem installed. And of course, download these files and stick them in a handy directory.

Then you'll want to retrieve the necessary keys and tokens from apps.twitter.com, as well as ensure that your app has read/write/dm permissions.

Create a `keys.yml` file in the same directory as fury.rb and fill it with your username, keys, and tokens as follows:

```
:user: "twitterHandle" # no @ symbol
:consumer_key: "abdcefghijklmnopqrstuvwxyz"
:consumer_secret: "1234567890"
:access_token: "abcdefghijklmnopqrstuvwxyz"
:access_token_secret: "1234567890:
```


After that's in order, in Terminal, `cd` to the directory where fury lies and enter `ruby fury.rb`. If everything goes correctly, it should ask `What do you want to do?` with two options. Simply enter `1`, or `2`, etc. and follow the instructions.
