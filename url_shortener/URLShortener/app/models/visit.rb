# == Schema Information
#
# Table name: visits
#
#  id         :bigint           not null, primary key
#  user_id    :integer          not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  url_id     :integer          not null
#


class Visit < ApplicationRecord
  validates :user_id, presence: true
  validates :url, presence: true
  validates :url_id, presence: true

  def self.record_visit(user, shortened_url)
    Visit.create(user_id: user.id, url: shortened_url.short_url, url_id: shortened_url.id)
  end

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: 'User'

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: 'ShortenedUrl'
end
