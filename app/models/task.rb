class Task < ApplicationRecord
    validates :name, length: {maximum: 20}, presence :true
    validates :memo, length: {maximum: 100}
end
