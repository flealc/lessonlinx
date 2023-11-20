class LessonPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    teacher? || @user.admin?
  end

  def create?
    true
  end

  def update?
    show?
  end

  def destroy?
    show?
  end

  def bulk_new?
    true
  end
  
  def bulk_create?
    true
  end

  def select_delete?
   true
  end

  def bulk_delete?
    show?
  end

  private
    def teacher?
      @record.teacher_id == @user.id
    end
end
