class DailyShiftNotesMailer < ApplicationMailer

  helper  :application

  default from: 'varlandmetalservice@gmail.com',
          to: ['Toby Varland <toby.varland@varland.com>', 'Toby Varland <varland@gmail.com>']

  def daily_summary_email
    @yesterday = Date.today - 1
    @first_shift_notes = ShiftNote.with_date(@yesterday).with_shift(1).sorted_by('created_at')
    @second_shift_notes = ShiftNote.with_date(@yesterday).with_shift(2).sorted_by('created_at')
    @third_shift_notes = ShiftNote.with_date(@yesterday).with_shift(3).sorted_by('created_at')
    mail(subject: 'Daily Shift Notes Summary')
  end

end