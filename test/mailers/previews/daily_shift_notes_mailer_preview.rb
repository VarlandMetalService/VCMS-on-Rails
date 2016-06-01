# Preview all emails at http://localhost:3000/rails/mailers/daily_shift_notes_mailer
class DailyShiftNotesMailerPreview < ActionMailer::Preview
  def daily_summary_email
    DailyShiftNotesMailer.daily_summary_email
  end
end