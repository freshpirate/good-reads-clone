class BooksController < ApplicationController
  before_filter :require_admin_privileges, only: [:new, :create, :update, :destroy, :edit]
  before_filter :require_user, only: [:show]

  # GET /books
  # GET /books.json
  def index
    # @book = Book.all

    respond_to do |format|
      format.html do # index.html.erb
        @books = Book.paginate(:page => params[:page])
      end
      format.json do
        @books = Rails.cache.fetch('books'){
          Book.all
        }
        if params[:page] && params[:per_page]
          # @books1 = Book.page(params[:page]).per(params[:per_page])
          m = params[:page].to_i
          n = params[:per_page].to_i

          s_idx = ((m - 1) * n)
          e_idx = (m * n) - 1

          total_pages = (@books.length / n.to_f).ceil
          @books = @books[s_idx..e_idx]

          jsonObj = {
            'meta': { 'total_pages': total_pages },
            'books': @books.as_json
          }

          render json: jsonObj
        else
          render json: { 'books': @books.as_json }
        end
      end
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show

    # byebug
    @book = Book.find(params[:id])
    @review_items = @book.reviews.paginate(page: params[:page])
    @status_categories = StatusCategory.all
    @current_status = current_user.user_book_statuses.find_by_book_id(@book)
    
    @relationship = @book.reviews.find_by_user_id(current_user.id)
    
    if @relationship.nil?
      @relationship = Review.new
      @relationship.user=current_user
      @relationship.book=@book
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def book_params
      params.require(:book).permit(:author, :cover, :isbn_number, :language, :published_year, :publisher, :synopsis, :title)
    end
end
