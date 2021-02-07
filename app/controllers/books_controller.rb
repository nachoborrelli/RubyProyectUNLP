require 'zip'

class BooksController < ApplicationController
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  helper_method :export


  # GET /books
  def index
    @books = current_user.books
  end

  # GET /books/1
  def show
    if current_user.id != @book.user_id
      redirect_to books_url, notice: "El cuaderno al que intentas acceder es privado."
    end
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    if current_user.id != @book.user_id
      redirect_to books_url, notice: "El cuaderno al que intentas acceder es privado."
    end
  end


  # POST /books
  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to @book, notice: "El cuaderno se ha guardado correctamente."
    else
      render :new
    end

  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'El cuaderno se ha actualizado correctamente.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to books_url, notice: 'El cuaderno se ha eliminado correctamente.'
  end


  def export
    @book = Book.find(params[:id])
    compiled_file = Zip::OutputStream.write_buffer do |zip_file|
      @book.notes.each do |note|
        zip_file.put_next_entry("#{note.title}.html")
        zip_file << note.export
      end
    end
    compiled_file.rewind
    data = compiled_file.sysread

    send_data data, filename: "#{@book.title}.zip", :type => 'application/zip'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title)
    end

end

