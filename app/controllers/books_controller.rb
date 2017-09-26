class BooksController < ApplicationController
  before_filter :set_book, only: [:show, :update, :destroy]
  def instructions
  	render template: "books/instructions"
  end

  # GET /books
  def index
    @books = Book.all

    render json: @books.to_json
  end

  # GET /books/1
  def show
    render json: @book
  end

  # POST /books
  def create
    begin
      @book = Book.new
      @book.title = params[:title]
      @book.author = params[:author]
      @book.publisher = params[:publisher]
      @book.categories = params[:categories]

      if @book.save
        render json: @book, status: :created, location: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end

  # PATCH/PUT /books/1
  def update
    begin
      @book.lastCheckedOutBy = params[:lastCheckedOutBy]
      @book.lastCheckedOut = Time.now.strftime("%Y-%m-%d %H:%M:%S %Z")
      if @book.save
        render json: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end

  # DELETE /books/1
  def destroy
    begin
      @book.destroy
    	head :no_content
  	rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end

  # DELETE ALL /books/clean
  def destroy_all
  	begin
    	Book.destroy_all
    	head :ok
  	rescue Exception => e
      raise Exception.new(build_error(400, e.message))
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    def build_error(code, message)
	    {
	        code: code,
	        message: message,
	        success: false
	    }.to_json
  	end
end
