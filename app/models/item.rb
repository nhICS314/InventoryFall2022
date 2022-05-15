class Item < ApplicationRecord
acts_as_paranoid
  
validates :name, presence: true
validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
validates :description, presence: true
validates :sku, presence: true, uniqueness: { case_sensitive: false }
validates :count, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  
after_restore :remove_delete_comment
  private
    def remove_delete_comment
      self.update(deletedComment: nil)
    end
end
