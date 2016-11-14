namespace :vcms do


  desc "updates all google documents in documents table"
  task update_all_google_documents: :environment do
    Document.all.each do |d|
      d.update_google_info
    end
  end

end
