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
    index = bb.attr('href').indexOf('ip_address')
    ##Giving the <a hrefs>'s unique classes would make this if-block simpler.
    if index > 0
      host = bb.attr('href').substring(index+11)
    else if !bb.attr('id')
      address = 'td[data-column_name="Public IP"] a'
      host = bb.closest('tr').find(address).text().trim()
    else return
    bb.attr('href', "ssh://#{username}@#{host}")
    bb.removeAttr 'data-popup'
    bb.removeAttr 'data-behaves'

setup()

