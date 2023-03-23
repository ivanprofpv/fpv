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
    user.admin? || user_author?
  end

  def create?
    true
  end

  def destroy?
    user.admin? || user_author?
  end

  private

  def user_author?
    # byebug
    user == record.user
  end
end