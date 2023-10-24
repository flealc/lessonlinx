require "icalendar"

class CalendarController < ApplicationController
  skip_before_action :authenticate_user!, only: :serve

  
  def serve
    
    calendar = User.find(params[:id]).generate_calendar

    send_data calendar.to_ical, type: "text/calendar", disposition: "inline", filename: "teaching_calendar.ics"
  end

end
