class InvalidContactsController < ApplicationController
  before_action :authenticate_user!
  def index
    @invalid_contacts = InvalidContact.all
  end
end
