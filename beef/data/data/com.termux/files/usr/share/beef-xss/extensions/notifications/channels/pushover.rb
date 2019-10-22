require 'rushover'

module BeEF
module Extension
module Notifications
module Channels

    class Pushover

        def initialize(message)
            @config = BeEF::Core::Configuration.instance

            # Configure the Pushover Client
            client = Rushover::Client.new(@config.get('beef.extension.notifications.pushover.app_key'))

            res = client.notify(@config.get('beef.extension.notifications.pushover.user_key'), message)
            print_error '[Notifications] Pushover notification failed' unless res.ok?
        rescue => e
            print_error "[Notifications] Pushover notification initialization failed: '#{e.message}'"
        end
    end
end
end
end
end

