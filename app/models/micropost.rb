class Micropost < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user

  validates :content, presence: true, length: { maximum: 5000 }
  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'

  def self.text_search(query)
    if query.present?
      # SQLite
      where('content like ?', "%#{query}%")
    else
      scoped
    end
  end
end