class DailyShiftNotesMailer < ApplicationMailer

  helper  :application

  default from: 'varlandmetalservice@gmail.com',
          to: ['Shift Notes Recipients <dailyshiftnotes@varland.com>']

  def specific_note_email note, group
    @note = note
    recipient = nil
    case group
      when 'it'
        recipient = 'IT <it@varland.com>'
      when 'lab'
        recipient = 'Lab <lab@varland.com>'
      when 'maintenance'
        recipient = 'Maintenance <maint@varland.com>'
      else
        return
    end
    recipient = 'Toby Varland <toby.varland@varland.com>'
    mail(subject: 'Shift Note Alert',
         to: recipient)
  end

  def daily_summary_email
    @yesterday = Date.today - 1
    @first_shift_notes = ShiftNote.with_date(@yesterday).with_shift(1).sorted_by('created_at')
    @second_shift_notes = ShiftNote.with_date(@yesterday).with_shift(2).sorted_by('created_at')
    @third_shift_notes = ShiftNote.with_date(@yesterday).with_shift(3).sorted_by('created_at')
    mail(subject: 'Daily Shift Notes Summary')
  end

end