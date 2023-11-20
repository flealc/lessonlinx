class ContactPolicy < ApplicationPolicy
  def index?
    false
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


  private
    def teacher?
      @record.student.teacher_id == @user.id
    end
  
end
