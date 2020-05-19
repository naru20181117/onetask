# frozen_string_literal: true

module Order
  extend ActiveSupport::Concern

  included do
    scope :select_asc, ->(sort_column) do
      order("#{sort_column} ASC")
    end
  end
end
