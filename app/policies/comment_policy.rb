class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    upvote?
  end

  def upvote?
    true
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    admin? || user_author?
  end

  def create?
    true
  end

  def destroy?
    admin? || user_author?
  end

  private

  def admin?
    if user.present?
      user.admin?
    end
  end

  def user_author?
    if user.present?
      user == record.user
    end
  end
end