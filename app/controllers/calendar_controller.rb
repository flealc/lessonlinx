require "icalendar"

class CalendarController < ApplicationController
  skip_before_action :authenticate_user!, only: :serve

  
  def serve
    
    begin
      user = User.find(params[:id])
      calendar =  user.generate_calendar
      send_data calendar.to_ical, type: "text/calendar", disposition: "inline", filename: "teaching_calendar.ics"
    rescue ActiveRecord::RecordNotFound
      send_data "The requested calendar is no longer available.", status: :gone
    end
  
  end

end
