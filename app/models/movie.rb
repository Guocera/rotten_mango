class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :image,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past, if: :release_date

  mount_uploader :image, ImageUploader

  # Scopes
  def self.search_by_title(title)
    where("title LIKE :title", title: "%#{title}%")
  end

  def self.search_by_director(director)
    where("director LIKE :director", director: "%#{director}%")
  end

  scope :duration_less_than_90, -> { where("runtime_in_minutes < 90") }
  scope :duration_btwn_90_and_120, -> { where("runtime_in_minutes > 90 AND runtime_in_minutes < 120") }
  scope :duration_more_than_120, -> { where("runtime_in_minutes > 120") }


  def review_average
    reviews.size == 0 ? 0 : (reviews.sum(:rating_out_of_ten).to_f/reviews.size.to_f).round(1)
  end

  private

  def release_date_is_in_the_past
    errors.add(:release_date, "should be in the past") if release_date > Date.today
  end

end
