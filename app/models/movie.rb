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

  def review_average
    reviews.size == 0 ? 0 : (reviews.sum(:rating_out_of_ten).to_f/reviews.size.to_f).round(1)
  end

  private

  def release_date_is_in_the_past
    errors.add(:release_date, "should be in the past") if release_date > Date.today
  end

end
