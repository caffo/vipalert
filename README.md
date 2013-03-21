# ★  vip_alert.rb (wip)

Ruby script that uses twillo to send you a text message when an email from someone important arrives in your gmail inbox. Poor man alternative to [Awayfind](https://www.awayfind.com/).

Usable, but still a work in progress.

## Installation instructions

* Checkout the repository in your server 
* Bundle install
* Edit the config.yaml file and add your twillo info and VIP email address
* run vip_alert.rb thru a cron job. I have mine set to run every 5 minutes

## Requirements

* Gmail 
* Twillo

## Planned features

* VIP subjects
* VIP domains
* Multiple accounts per instance

## Contributing to vip_alert

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2013 rodrigo franco (caffo). See LICENSE.txt for further details.
