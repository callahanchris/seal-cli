require 'rubygems'
require 'mechanize'

puts 'Enter a phone #'
phone_num = gets.strip
phone_num = phone_num.gsub(/[^0-9]/, '')

if [10, 11].include?(phone_num.length)
  puts phone_num
else
  puts 'enter a phone #'
end

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

a.get('http://www.textfromarose.com/') do |page|
  form = page.forms.first
  form.field_with(name: 'phone_number').value = phone_num
  form.click_button
end
