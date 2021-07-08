namespace :import do
  desc "Import authors from CSV"
  task authors: :environment do 
    file_path = File.join Rails.root, "authors.csv"
    CSV.foreach(file_path, headers: true) do |row|
        author = Author.create(email: row["email"],password: row["pwd"],password_confirmation: row["pwd_cnfrm"])
        puts("#{author.username} - creation failed - #{author.errors.full_messages.join(';')}") if author.errors.any?
        puts("#{author.username} - created successfully") if not author.errors
    end
  end
end
