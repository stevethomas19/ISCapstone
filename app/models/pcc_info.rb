class PccInfo < ActiveRecord::Base
  def self.import(file)
    CSV.foreach(file.path, headers: true, header_converters: lambda { |h| h.try(:downcase) }) do |row|
      pcc_infos_hash = row.to_hash
      cleaned_row = clean_data(pcc_infos_hash)
      PccInfo.create!(cleaned_row)
    end # end CSV.foreach
  end # end self.import(file)

  def self.clean_data(row)
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
    row['loan'] = row['loan'].present? ? true : false
    row
  end
end
