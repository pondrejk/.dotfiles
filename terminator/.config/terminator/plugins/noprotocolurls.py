import terminatorlib.plugin as plugin
import re
available = ['NoProtocolURLHandler']

class NoProtocolURLHandler(plugin.URLHandler):
    """All that ends with .com is treated as url"""
  
  capabilities = ['url_handler']
  handler_name = 'no_protocol_url'
  match = r'.*\.com'

  def callback(self, url):
      return(url)
