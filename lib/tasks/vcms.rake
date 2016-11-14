namespace :vcms do

  desc "updates all google documents in documents table"
  task update_all_google_documents: :environment do
    Document.all.each do |d|
      d.update_google_info
    end
  end

  desc "adds all missing files from google drive folder to category"
  task add_all_missing_google_documents: :environment do
    Category.all.each do |c|
      c.get_google_documents
    end
  end

end
