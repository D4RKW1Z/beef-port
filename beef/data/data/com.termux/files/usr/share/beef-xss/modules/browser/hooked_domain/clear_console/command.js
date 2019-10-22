//
// Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
// Browser Exploitation Framework (BeEF) - http://beefproject.com
// See the file 'doc/COPYING' for copying permission
//

beef.execute(function() {
  try {
    beef.debug("Clearing console...");
    console.clear();
    beef.net.send("<%= @command_url %>", <%= @command_id %>, "result=cleared console", beef.are.status_success());
  } catch(e) {
    beef.net.send("<%= @command_url %>", <%= @command_id %>, "fail=could not clear console", beef.are.status_error());
  }
});
