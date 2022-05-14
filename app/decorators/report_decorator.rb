# frozen_string_literal: true

module ReportDecorator
  def created_date
    l(created_at.to_date)
  end
end
