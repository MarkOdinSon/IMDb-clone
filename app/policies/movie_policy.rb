class MoviePolicy < ApplicationPolicy
  def new?
    check_user_role
  end

  def create?
    check_user_role
  end

  def edit
    check_user_role
  end

  def update
    check_user_role
  end

  def destroy
    check_user_role
  end

  private

  def check_user_role
    user.admin? or user.super_admin? if user
  end
end
