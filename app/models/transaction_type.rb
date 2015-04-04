# == Schema Information
#
# Table name: transaction_types
#
#  id                         :integer          not null, primary key
#  community_id               :integer
#  transaction_process_id     :integer
#  sort_priority              :integer
#  price_field                :boolean
#  price_quantity_placeholder :string(255)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  url                        :string(255)
#  shipping_enabled           :boolean          default(FALSE)
#  name_tr_key                :string(255)
#  action_button_tr_key       :string(255)
#
# Indexes
#
#  index_transaction_types_on_community_id  (community_id)
#  index_transaction_types_on_url           (url)
#

class TransactionType < ActiveRecord::Base
  attr_accessible(
    :community_id,
    :price_field,
    :sort_priority,
    :price_quantity_placeholder,
    :transaction_process_id,
    :shipping_enabled,
    :name_tr_key,
    :action_button_tr_key,
    :url
  )

  belongs_to :community

  has_many :listing_units

  validates_presence_of :community

  # TODO this can be removed
  def self.columns
    super.reject { |c| c.name == "type" || c.name == "preauthorize_payment" || c.name == "price_per" }
  end

  # TODO this can be removed
  def self.inheritance_column
    :a_non_existing_column_because_we_want_to_disable_inheritance
  end

  def to_param
    url
  end

  def self.find_by_url_or_id(url_or_id)
    self.find_by_url(url_or_id) || self.find_by_id(url_or_id)
  end
end
