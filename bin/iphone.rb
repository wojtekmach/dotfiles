require 'nokogiri'

check_url = "http://iphone-check.herokuapp.com/?zip=10001&color=grey&provider=unlocked"
store_url = "http://store.apple.com/us/cart"
email = ENV.fetch('EMAIL')

def found?(url)
  html = `curl --silent '#{url}'`
  @body = Nokogiri::HTML(html)
  @body.css('table tr')[2..6].css('td.yup').any?
end

loop do
  if found?(check_url)
    puts check_url
    File.open('/tmp/a.html', 'w') { |f| f.print @body }
    `echo 'found!' | mail -s "found" #{email}`
    `open '#{check_url}'`
    `open #{store_url}`
  end

  sleep 30
end
