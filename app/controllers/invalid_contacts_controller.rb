class InvalidContactsController < ApplicationController
  def index
    @invalid_contacts = InvalidContact.all
  end
end
