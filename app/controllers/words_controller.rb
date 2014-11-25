class WordsController < ApplicationController
  before_action :check_if_login
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :current_user

  # GET /words
  # GET /words.json
  def index
    @words = Word.all
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
    @chapter = Chapter.find(params[:chapter_id])
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create

    #检查是否已经存在单词
    @word = Word.find_by_content(params[:word][:content])

    unless @word
      #不存在则创建单词
      @word = Word.new(word_params)
    end


    @chapter = Chapter.find(params[:word][:chapter_id])

  
    respond_to do |format|
      #创建单词和章节的关联
      if @word.save && WordChapter.create(:word_id => @word.id, :chapter_id => @chapter.id)
        format.html { redirect_to @chapter , notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:content, :mean, :w_type, :phonetic)
    end
end
