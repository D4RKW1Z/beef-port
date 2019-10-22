#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
# // Phonegap_globalization_status

class Phonegap_globalization_status < BeEF::Core::Command

  def post_execute
    content = {}
    content['Result'] = @datastore['result']
    save content
  end 
end
