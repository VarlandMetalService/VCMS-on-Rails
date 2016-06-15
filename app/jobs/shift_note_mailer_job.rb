class ShiftNoteMailerJob
  @queue = :email

  def self.perform(note, group)
    DailyShiftNotesMailer.specific_note_email(note, group).deliver_now
  end
end