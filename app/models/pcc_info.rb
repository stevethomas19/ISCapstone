class PccInfo < ActiveRecord::Base
  require 'gender_detector'

  def self.search(query)
    query = "%#{query}%"
    where('(name ILIKE ?) OR (pcc ILIKE ?)', query, query)
  end

  def self.import(file)
    return if file.nil?
    detector = GenderDetector.new(case_sensitive: false)
    CSV.foreach(file.path, headers: true, header_converters: lambda { |h| h.try(:downcase) }) do |row|
      pcc_infos_hash = row.to_hash
      cleaned_row = clean_data(pcc_infos_hash)
      unless cleaned_row.nil?
        record = PccInfo.create!(cleaned_row)
        predict_gender(record, detector)
      end
    end # end CSV.foreach
  end # end self.import(file)

  def self.clean_data(row)
    row = nil if row['pcc'].blank? || row['name'].blank? #Remove blank names
    return row if row.nil?
    row = nil if (row['pcc'].downcase.include?('doe') || row['name'].downcase.include?('doe')) #remove john doe
    return row if row.nil?
    row = nil if (row['name'].downcase.include?('balance') || row['purpose'].downcase.include?('balance')) #remove balance transfers
    return row if row.nil?

    row['filed'] = row['filed'].present? ? true : false
    row['tran_id'] = row['tran_id'].to_i

    date = row['tran_date'].split('/')
    date = date.unshift(date.delete_at(2))
    unless date[0].length == 4
      date[0].prepend('20')
    end
    date = date.join('-')
    row['tran_date'] = date.to_datetime

    row['tran_amt'] = row['tran_amt'].to_i
    row['inkind'] = row['inkind'].present? ? true : false
    row['tran_type'] = 'Contribution' if row['inkind']
    row['loan'] = row['loan'].present? ? true : false
    row['loan'] = 'Contribution' if row['loan']
    row
  end

  def self.predict_gender(record, detector)
    name = record.name.include?(', ') ? record.name.split(', ')[1] : record.name.split(' ')[0]

    case detector.get_gender(name)
    when :male
      record.gender = 'male'
    when :female
      record.gender = 'female'
    else
      record.gender = 'unknown'
    end
    record.save
  end
end
