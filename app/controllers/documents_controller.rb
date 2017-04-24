class DocumentsController < ApplicationController
  load_and_authorize_resource

  respond_to :html

  def index
    @documents = current_user.documents
    respond_with(@documents)
  end

  def show
    respond_with(@document)
  end

  def new
    @document = current_user.documents.build
    respond_with(@document)
  end

  def edit
  end

  def create
    @document = current_user.documents.build(document_params)
    @document.save
    respond_with(@document)
  end

  def update
    @document.update(document_params)
    respond_with(@document)
  end

  def destroy
    @document.destroy
    respond_with(@document)
  end

  private

  def document_params
    params.require(:document).permit(:name, :description, :schema_file_upload)
  end
end
