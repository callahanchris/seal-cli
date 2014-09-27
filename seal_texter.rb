require 'rubygems'
require 'mechanize'

class SealTexter
  attr_reader :phone

  def initialize(phone)
    @phone = phone
  end

  def text_lyrics
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    a.get('http://www.textfromarose.com/') do |page|
      form = page.forms.first
      form.field_with(name: 'phone_number').value = phone
      form.click_button
    end
  end
end

class CLIRunner
  attr_accessor :phone

  def run
    puts 'Enter a phone #'
    verify_phone_num
  end

  def verify_phone_num
    self.phone = gets.strip
    self.phone = phone.gsub(/[^0-9]/, '')

    [10, 11].include?(phone.length) ? text : run
  end

  def text
    puts "Texting #{phone}..."
    SealTexter.new(phone).text_lyrics
  end
end

CLIRunner.new.run