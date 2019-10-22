#
# Copyright (c) 2006-2018 Wade Alcorn - wade@bindshell.net
# Browser Exploitation Framework (BeEF) - http://beefproject.com
# See the file 'doc/COPYING' for copying permission
#
class Pretty_theft < BeEF::Core::Command
  
  def self.options
    @configuration = BeEF::Core::Configuration.instance
    proto = @configuration.get("beef.http.https.enable") == true ? "https" : "http"
    beef_host = @configuration.get("beef.http.public") || @configuration.get("beef.http.host")
    beef_port = @configuration.get("beef.http.public_port") || @configuration.get("beef.http.port")
    base_host = "#{proto}://#{beef_host}:#{beef_port}"
    logo_uri = "#{base_host}/ui/media/images/beef.png"
    return [
		{'name' => 'choice', 'type' => 'combobox', 'ui_label' => 'Dialog Type', 'store_type' => 'arraystore', 'store_fields' => ['choice'], 'store_data' => [['Facebook'],['LinkedIn'],['Windows'],['YouTube'],['Yammer'],['IOS'],['Generic']], 'valueField' => 'choice', 'value' => 'Facebook', editable: false, 'displayField' => 'choice', 'mode' => 'local', 'autoWidth' => true },
       		
		{'name' => 'backing', 'type' => 'combobox', 'ui_label' => 'Backing', 'store_type' => 'arraystore', 'store_fields' => ['backing'], 'store_data' => [['Grey'],['Clear']], 'valueField' => 'backing', 'value' => 'Grey', editable: false, 'displayField' => 'backing', 'mode' => 'local', 'autoWidth' => true },

		{'name' =>'imgsauce', 'description' =>'Custom Logo', 'ui_label'=>'Custom Logo (Generic only)', 'value' => logo_uri}
    ]
  end
  
  #
  # This method is being called when a zombie sends some
  # data back to the framework.
  #
  def post_execute
    save({'answer' => @datastore['answer']})
  end
  
end
