#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#

module BeEF
module Core
module Models

  # @note Table stores the commands that have been sent to the Hooked Browsers.
  class Command

    include DataMapper::Resource

    storage_names[:default] = 'commands'

    property :id, Serial
    property :data, Text
    property :creationdate, String, :length => 15, :lazy => false
    property :label, Text, :lazy => false
    property :instructions_sent, Boolean, :default => false

    has n, :results


    # Save results and flag that the command has been run on the hooked browser
    # @param [String] hook_session_id The session_id.
    # @param [String] command_id The command_id.
    # @param [String] command_friendly_name The command friendly name.
    # @param [String] result The result of the command module.
    def self.save_result(hook_session_id, command_id, command_friendly_name, result, status)
      # @note enforcing arguments types
      command_id = command_id.to_i

      # @note argument type checking
      raise Exception::TypeError, '"hook_session_id" needs to be a string' if not hook_session_id.string?
      raise Exception::TypeError, '"command_id" needs to be an integer' if not command_id.integer?
      raise Exception::TypeError, '"command_friendly_name" needs to be a string' if not command_friendly_name.string?
      raise Exception::TypeError, '"result" needs to be a hash' if not result.hash?
      raise Exception::TypeError, '"status" needs to be an integer' if not status.integer?

      # @note get the hooked browser structure and id from the database
      hooked_browser = BeEF::Core::Models::HookedBrowser.first(:session => hook_session_id) || nil
      raise Exception::TypeError, "hooked_browser is nil" if hooked_browser.nil?
      raise Exception::TypeError, "hooked_browser.id is nil" if hooked_browser.id.nil?
      hooked_browser_id = hooked_browser.id
      raise Exception::TypeError, "hooked_browser.ip is nil" if hooked_browser.ip.nil?
      hooked_browser_ip = hooked_browser.ip

      # @note get the command module data structure from the database
      command = first(:id => command_id.to_i, :hooked_browser_id => hooked_browser_id) || nil
      raise Exception::TypeError, "command is nil" if command.nil?

      # @note create the entry for the results 
      command.results.new(:hooked_browser_id => hooked_browser_id,
                          :data => result.to_json,:status => status,:date => Time.now.to_i)
      command.save

      s = self.show_status(status)
      log = "Hooked browser [id:#{hooked_browser.id}, ip:#{hooked_browser.ip}] has executed instructions (status: #{s}) from command module [cid:#{command_id}, mod: #{command.command_module_id}, name:'#{command_friendly_name}']"
      BeEF::Core::Logger.instance.register('Command', log, hooked_browser_id)
      print_info log
    end

    def self.show_status(status)
      case status
        when -1
          result = 'ERROR'
        when 1
          result = 'SUCCESS'
        else
          result = 'UNKNOWN'
      end
      result
    end

  end
end
end
end
