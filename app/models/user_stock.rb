# == Schema Information
#
# Table name: user_stocks
#
#  id            :integer          not null, primary key
#  stock_tickers :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_user_stocks_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class UserStock < ApplicationRecord
  belongs_to :user
  belongs_to :user
end
