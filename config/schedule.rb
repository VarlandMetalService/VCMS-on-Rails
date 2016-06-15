# http://github.com/javan/whenever

every 1.day, :at => '8:00 am' do
  rake "send_daily_shift_notes"
end