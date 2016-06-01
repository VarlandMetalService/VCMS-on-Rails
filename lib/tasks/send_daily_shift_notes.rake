# file: lib/tasks/send_daily_shift_notes.rake

desc 'send daily shift notes summary'
task send_daily_shift_notes: :environment do
  DailyShiftNotesMailer.daily_summary_email.deliver!
end