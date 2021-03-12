# frozen_string_literal: true

class LocalizedFieldsUniquenessValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      record.errors.add(field, :taken) if duplicated?(record, field)
    end
  end

  private

    def duplicated?(record, field)
      existing_values =
        record.class.public_send(record.region).where.not(id: record.id).map do |item|
          item.public_send(field).to_s.downcase
        end

      record.public_send(field).to_s.downcase.in?(existing_values)
    end
end
