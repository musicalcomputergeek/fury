# unleash your fury on anyone on twitter
require 'rubygems'
require 'twitter'
require 'yaml'

KEYS = YAML.load_file('keys.yml')

# load config keys and tokens from .yml file
config = {
  :consumer_key        => KEYS[:consumer_key],
  :consumer_secret     => KEYS[:consumer_secret],
  :access_token        => KEYS[:access_token],
  :access_token_secret => KEYS[:access_token_secret],
}

$client = Twitter::REST::Client.new(config)

$client.user(KEYS[:user])

  puts "Account: #{KEYS[:user]}"
  puts 'What do you want to do?'
  puts '1. Unleash wrath and fury on a Twitter user'
  puts '2. Tweet a tweet'

# Unleash fury by spamming the user into oblivion

def choose_victim
  # get target account
  puts 'Who will receive your fury today? (Format: @username)'
  @victim = gets.chomp
  # number of spam tweets
  puts "How many tweets of fury do you want to send to #{@victim}"
  $severity = gets.to_i
  puts "How frequently do you want the tweets to be sent (in seconds)? \nNote: if you're sending more than 20 tweets at a time, \nset the timer to ~60 seconds."
  $seconds = gets.to_i
  # Confirm fury
  puts "(y/n) Release your fury on #{@victim} every #{$seconds.to_s} seconds for #{$severity.to_s} tweets? They might get mad..."
  @yn = gets.chomp
  # anaylize the input
  case @yn
  when "y"
    puts "Unleashing fury. Enjoy."
  $counter = 1
    # loop for amount of tweets
    begin
      $client.update("#{@victim} #{$counter.to_s}")
      puts ("Tweet #{$counter.to_s}")
      $counter += 1
      if $counter <= $severity
        sleep($seconds) # wait x seconds between tweets
      end
    end until $counter > $severity
    puts "Fury unleashed."
    exit
  when "n"
    puts "Ugh... wimp."
    exit
  else
    puts "What? I DIDN'T ASK FOR THAT COMMAND."
    exit
  end
end
# tweet an innocent tweet

def tweet_tweets
  puts 'Compose your tweet.'
  @tweet = gets
  # confirm tweet
  puts "(y/n) Are you sure you want to tweet: #{@tweet}"
  @yn2 = gets.chomp
  case @yn2
  when "y"
    begin
      $client.update("#{@tweet}")
      puts "Tweet sent."
      exit
    rescue Twitter::Error::TooManyRequests => error
      puts "Oops, we are rate limited. We will try again at: #{Time.now + error.rate_limit.reset_in + 5}"
      sleep error.rate_limit.reset_in + 5
      retry
    rescue Twitter::Error::ServiceUnavailable => error
      sleep(10)
      retry
    rescue Twitter::Error::Forbidden => error
      puts "You already tweeted \"#{@tweet}\""
    rescue Twitter::Error::NotFound => error
      puts "Sorry something went wrong. #{error}"
    end
  when "n"
    puts "Whatevs, dude."
    exit
  else
    puts "Sorry, that is not acceptable input, try again."
    exit
  end
end

# *** Code that executes at the beginning ***

@step1 = gets.chomp
case @step1
when "1"
  choose_victim
when "2"
  tweet_tweets
else
  puts "Sorry, that is not acceptable input, try again."
  exit
end
