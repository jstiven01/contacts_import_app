# frozen_string_literal: true

class ImportFilePolicy < ApplicationPolicy
  def index?
    true
  end

  def new?
    user.present?
  end

  private

  def import_file
    record
  end
end
