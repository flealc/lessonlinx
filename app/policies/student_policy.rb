class StudentPolicy < ApplicationPolicy

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

  def recent_lessons?
    show?
  end

  def student_lessons?
    show?
  end

  def select_delete?
    show?
  end

  def bulk_delete?
    show?
  end

  private
    def teacher?
      @record.teacher_id == @user.id
    end
end
