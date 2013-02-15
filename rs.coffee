__         = Zepto
username   = 'rightscale'
address    = 'td[data-column_name="Public IP"] a'
ssh_button = 'a[href*="managed_ssh"]'
retry_rate = 100

setup = () ->
  replace_ssh_event_handler()
  __('body').on 'DOMNodeInserted', (e) ->
    replace_ssh_event_handler()

replace_ssh_event_handler = () ->
  buttons = __(ssh_button)
  if !buttons.length then return
  buttons.each (i) ->
    bb = __(this)
    host = bb.attr('data-ssh-ip')
    bb.attr('href', "ssh://#{username}@#{host}")
    bb.removeAttr 'data-popup'
    bb.removeAttr 'data-behaves'

setup()

