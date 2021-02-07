require 'zip'

class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  def index
    @notes = current_user.notes
  end

  # GET /notes/1
  def show
    if current_user.id != @note.user_id
      redirect_to notes_url, notice: "La nota a la que intentas acceder es privada."
    end
  end

  # GET /notes/new
  def new
    if params[:book_id]
      @book = params[:book_id]
    end
    @note = Note.new
  end


  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = Note.new(note_params)
    @note.user = current_user

    if @note.save
      redirect_to @note, notice: 'Nota creada exitosamente!.'
    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Se actualizó la nota exitosamente!.'
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'La nota fue eliminada exitosamente!.'
  end


  def export
    @note = Note.find(params[:id])
    archivo = @note.export
    send_data archivo, filename: "#{@note.title}.html", :type => 'application/html'
  end


  def export_every
    compiled_file = Zip::OutputStream.write_buffer do |zip_file|
      current_user.notes.each do |note|
        zip_file.put_next_entry("#{note.title}.html")
        zip_file << note.export
      end
    end
    compiled_file.rewind
    data = compiled_file.sysread
    send_data data, filename: "EveryNote.zip", :type => 'application/zip'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:book_id, :title, :content)
    end


end
