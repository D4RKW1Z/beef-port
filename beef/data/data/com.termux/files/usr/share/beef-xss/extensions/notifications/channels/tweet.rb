#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
#
#
require 'twitter'

module BeEF
module Extension
module Notifications
module Channels
  
  class Tweet

    #
    # Constructor
    #
    def initialize(username, message)
      @config = BeEF::Core::Configuration.instance

      # configure the Twitter client
      client = Twitter::REST::Client.new do |config|
        config.consumer_key       = @config.get('beef.extension.notifications.twitter.consumer_key')
        config.consumer_secret    = @config.get('beef.extension.notifications.twitter.consumer_secret')
        config.oauth_token    = @config.get('beef.extension.notifications.twitter.oauth_token')
        config.oauth_token_secret = @config.get('beef.extension.notifications.twitter.oauth_token_secret')
      end

      begin
        client.direct_message_create(username, message)
      rescue
        print_error "Twitter send failed, verify tokens have Read/Write/DM acceess..."
      end
    end
  end
  
end
end
end
end

