class TestMailer < ApplicationMailer
  default from: 'sender@example.org'

  def hello
    mail(
      subject: 'Hello from LessonLinx',
      to: 'daily@lessonlinx.pro',
      from: 'daily@lessonlinx.pro',
      html_body: '<strong>Hello</strong> dear LessonLinx user.',
      track_opens: 'true',
      message_stream: 'daily-digest')
  end
end
