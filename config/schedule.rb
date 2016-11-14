# http://github.com/javan/whenever

every [:tuesday, :wednesday, :thursday, :friday, :saturday], :at => '8:00 am' do
  rake "send_daily_shift_notes"
end

every 1.hours do
  rake "vcms:update_all_google_documents"
end