# frozen_string_literal: true

class ImportFilesController < ApplicationController
  before_action :authenticate_user!
  def new
    @import_file = ImportFile.new
  end

  def index
    @imported_files = ImportFile.all
  end

  def import
    @import_file = current_user.import_files.build(name: params[:file].original_filename, state: 'processing')
    if @import_file.save
      @import_file.import_data(params)
      flash[:success] = 'File is processing.'
    else
      flash.now[:danger] = 'Failed to create a new file.'
    end
    redirect_to contacts_path
  end
end
