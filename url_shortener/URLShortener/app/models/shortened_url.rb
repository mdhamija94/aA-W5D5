# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint           not null, primary key
#  long_url  :string           not null
#  short_url :string           not null
#  user_id   :integer          not null
#

require 'securerandom'

class ShortenedUrl < ApplicationRecord
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: 'Visit'

  has_many :visitors,
    through: :visits,
    source: :user

  def self.random_code
    gen = SecureRandom.urlsafe_base64

    while ShortenedUrl.exists?(gen)
      gen = SecureRandom.urlsafe_base64
    end

    gen
  end

  def self.url_factory(user, long_url)
    short = ShortenedUrl.new
    short.user_id, short.long_url = user.id, long_url
    short.short_url = ShortenedUrl.random_code
    short.save!
  end
end
