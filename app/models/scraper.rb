class Scraper

  require 'open-uri'

  URL = 'https://news.washeriff.net/divisions/corrections-division/bookings/'

  def self.scrape_all
    doc = Nokogiri::HTML(open(URL))
    scrape_charge_types(doc)
    scrape_arrests(doc)
  end

  private

  def self.scrape_arrests(html_document)
    html_document.css('table').each do |table|
      array = table.at_css('p').text.split("\n\t\t\t")
      name = array[0].strip
      arrest_date = DateTime.strptime(array[4].split('Arrest Date:')[1].strip, '%H:%M:%S %m/%d/%y')
      arrest = Arrest.find_or_initialize_by(arrested_at: arrest_date, name: name)
      if arrest.new_record?
        arrest.raw_data = table
        arrest.external_mugshot_url = table.css('td')[0].css('img').attr('src').text.strip
        arrest.address = array[1].split(':')[1].strip
        arrest.city = array[2].split(':')[1].split('/')[0].strip
        arrest.state = array[2].split(':')[1].split('/')[1].strip
        arrest.pcf_number = array[3].split(':')[1].strip
        arrest.arrested_by = array[5].split(':')[1].strip
        arrest.agency = array[6].split(':')[1].strip
        if arrest.save
          table.css('.charge').each do |charge|
            charge_name = charge.text.strip
            statute = charge.next_sibling.next_sibling.text.strip.split("\n\t\t\t")[1].strip.split(':')[1].try(:strip)
            required_bond = charge.next_sibling.next_sibling.text.strip.split("\n\t\t\t")[3].strip.split(':')[1].strip.to_i
            classification = charge.next_sibling.next_sibling.text.strip.split("\n\t\t\t")[0].strip.split(':')[1].try(:strip)
            if charge_type = ChargeType.find_by(statute: statute)
              arrest.charges.create({
                statute: statute,
                required_bond: required_bond,
                charge_type: charge_type,
                classification: classification,
                name: charge_name
              })
            end
          end
        end
      end
    end
  end

  def self.scrape_charge_types(html_document)
    html_document.css('.charge').each do |charge|
      name = charge.text.try(:strip)
      statute = charge.next_sibling.next_sibling.text.strip.split("\n\t\t\t")[1].strip.split(':')[1].try(:strip)
      classification = charge.next_sibling.next_sibling.text.strip.split("\n\t\t\t")[0].strip.split(':')[1].try(:strip)
      ChargeType.create_with(classification: classification).find_or_create_by(statute: statute, name: name)
    end
  end

end
