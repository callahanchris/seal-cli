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
