class Item < ApplicationRecord
acts_as_paranoid
  
after_restore :remove_delete_comment


  private

    def remove_delete_comment
      self.update(deletedComment: nil)
    end
  
end
