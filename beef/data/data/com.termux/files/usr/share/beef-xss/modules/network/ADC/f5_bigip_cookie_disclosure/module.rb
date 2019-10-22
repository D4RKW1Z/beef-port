#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
class F5_bigip_cookie_disclosure < BeEF::Core::Command

  def post_execute
    return if @datastore['results'].nil?
    save({'BigIPCookie' => @datastore['results']})
  end

end
