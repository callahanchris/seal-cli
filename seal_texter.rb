require 'rubygems'
require 'mechanize'

class SealTexter
  attr_reader :phone, :message

  def initialize(phone, message)
    @phone, @message = phone, message
  end

  def text_lyrics
    a = Mechanize.new { |agent|
      agent.user_agent_alias = 'Mac Safari'
    }

    a.get('http://www.textfromarose.com/') do |page|
      form = page.forms.first
      form.field_with(name: 'phone_number').value = phone
      form.fields.last.value = message
      form.click_button
    end
  end
end

class SealCLI
  attr_accessor :phone, :message

  def run
    puts 'Enter a phone #'
    verify_phone_num
  end

  def verify_phone_num
    self.phone = gets.strip
    self.phone = phone.gsub(/[^0-9]/, '')

    [10, 11].include?(phone.length) ? choose_lyric_or_fact : run
  end

  def choose_lyric_or_fact
    puts 'Would you like to send a Seal _lyric_ or a Seal _fact_?'
    input = gets.chomp
    case
    when input =~ /lyric/i
      self.message = 'lyric'
      text
    when input =~ /fact/i
      self.message = 'fact'
      text
    else
      choose_lyric_or_fact
    end
  end

  def text
    puts "BAY-BEHHH"
    puts "Texting #{phone} an essential Seal #{message}!"
    SealTexter.new(phone, message).text_lyrics
  end
end

SealCLI.new.run