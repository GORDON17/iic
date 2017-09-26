class BooksController < ApplicationController
  before_filter :set_book, only: [:show, :update, :destroy]

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    # byebug
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    begin
    	@book.destroy
    	render json: build_success(200, 'Success')
  	rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end

  # DELETE ALL /books/clean
  def destroy_all
  	begin
    	Book.destroy_all
    	render json: build_success(200, 'Success')
  	rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:author, :categories, :lastCheckedOut, :lastCheckedOutBy, :publisher, :title, :url)
    end

    def build_error(code, message)
	    {
	        code: code,
	        message: message,
	        success: false
	    }.to_json
  	end
  	def build_success(code, message)
	    {
	        code: code,
	        message: message,
	        success: true
	    }.to_json
  	end
end
