module Observer
  extend ActiveSupport::Concern

  included do
    after_create :notify_object
  end

  private
  def notify_object
    Rails.logger.info "Object #{self.class.name} created!"
  end
end
