desc "Scrape Washington County (Utah) Sheriff's office for new arrests"
task scrape_arrests_and_upload_mugshots: :environment do
  Scraper.scrape_all
  Arrest.upload_mugshots
end
