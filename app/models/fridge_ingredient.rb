class FridgeIngredient < ApplicationRecord
  belongs_to :ingredient
  belongs_to :fridge
  validates :date_in, presence: true


  def expiration_date
    self.date_in + self.ingredient.expiration_days
  end

  def days_until_expiration
    @days_in_fridge = (Date.today - self.date_in).to_i
    @days_left = (self.ingredient.expiration_days - @days_in_fridge).to_i
  end

  def expiration_message
    if self.days_until_expiration == 0
      "Expires today."
    elsif self.days_until_expiration > 0
        "#{self.days_until_expiration} days"
    elsif self.days_until_expiration == 1
        "#{self.days_until_expiration} day"
    else
        @days_since = self.days_until_expiration * -1
        if @days_since == 1
          "#{@days_since} day"
        else
          "#{@days_since} days"
        end
    end
  end

end
