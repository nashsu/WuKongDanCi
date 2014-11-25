class ReciteTasksController < ApplicationController
  before_action :check_if_login
  before_action :set_recite_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user

  # GET /recite_tasks
  # GET /recite_tasks.json
  def index
    @recite_tasks = User.first.recite_tasks

    @today_recite_tasks = ReciteTask.where(:user_id => 1, :next_time => Date.today...Date.tomorrow)

  end


  def go
    @recite_task = ReciteTask.find(params[:id])

    word_ids = @recite_task.word_ids.split(",")

    #检测是否是未执行完的任务
    if @recite_task.tmp_record && @recite_task.tmp_record != ""

      current_word_id = @recite_task.tmp_record.split(",").last.split(":")[0]
       @word = Word.find(word_ids[word_ids.index(current_word_id) + 1])

    else
      @recite_task.update(:tmp_record => "")

      @word = Word.find(word_ids.first)

    end

  end


  def next_word

    recite_task = ReciteTask.find(params[:recite_task_id])


    #更新上一单词记录

    result = params[:result]

    result_id = params[:word_id]

    render :json => {:code => 500} unless result && result_id

    recite_task.tmp_record = recite_task.tmp_record + "#{result_id}:#{result},"

    recite_task.save

    #获取下一个单词
    word_ids = recite_task.word_ids.split(",")

    next_ptr = word_ids.index(result_id) + 1

    #如果是最后一个单词则跳转到结束页面
    if next_ptr == word_ids.count
      render :json => {:code => 302 }
    else
      #否则返回下一个单词
      next_word = Word.find(word_ids[next_ptr].to_i)
      render :json => {:code => 200, :id => next_word.id, :word => next_word.content, :mean => next_word.mean }
    end
    
  end


  def end
    @recite_task = ReciteTask.find(params[:id])

    if @recite_task.tmp_record
      results = @recite_task.tmp_record.split(",")

      @total_count = @recite_task.word_ids.split(",").count
      @err_count = 0

      results.each do |result|
        word_id = result.split(":")[0].to_i

        #更新易错词记录
        recite_word = ReciteWord.where(:word_id => word_id, :user_id => 1, :recite_task_id => @recite_task.id).last

        #针对错题创建易错词记录
        if result.split(":")[1].to_i == 0

          @err_count += 1


          if recite_word
            recite_word.score = (recite_word.score - 10) if (recite_word.score - 10 >= 0)
            recite_word.save
          else
            ReciteWord.create(
              :user_id => 1,
              :word_id => word_id,
              :recite_task_id => @recite_task.id,
              :score => 70
              )
          end
        else
        #查看正确的单词是否之前有过易错词记录，有的话更新易错分数

          if recite_word
            if recite_word.score + 10 == 100
              recite_word.destroy
            else
              recite_word.score = ( recite_word.score + 10 ) 
              recite_word.save
            end
          end
        end
      end

      unless @recite_task.start_time
        start_time = Time.now
        next_time = start_time
      else
        #当天复习
        start_time =  @recite_task.start_time
        next_time = @recite_task.next_time

        if next_time == start_time
          #隔天复习
          next_time = start_time + 86400
        else
          #检测是否在指定复习时间前自行复习，如果自行复习则不更新下次复习时间
          if Time.now >= next_time
            range = (next_time - start_time)/86400

            case range
            when 1
              next_time = start_time + 86400*2
            when 2
              next_time = start_time + 86400*4
            when 4
              next_time = start_time + 86400*7
            when 7
              next_time = start_time + 86400*15
            when 15
              
            end
          end

        end
      end

      @recite_task.update(
        :tmp_record => nil,
        :start_time => start_time,
        :next_time => next_time
        )
    else
      redirect_to recite_tasks_path
    end

  end

  # GET /recite_tasks/1
  # GET /recite_tasks/1.json
  def show
  end

  # GET /recite_tasks/new
  def new
    @recite_task = ReciteTask.new
  end

  # GET /recite_tasks/1/edit
  def edit
  end

  # POST /recite_tasks
  # POST /recite_tasks.json
  def create
    @recite_task = ReciteTask.new

    @recite_task.user_id = 1

    @recite_task.task_type = params[:task_type].to_i

    @recite_task.word_ids = Chapter.find(params[:chapter_id]).words.map{|word| word.id}.join(",")

    respond_to do |format|
      if @recite_task.save
        format.html { redirect_to recite_tasks_path, notice: 'Recite task was successfully created.' }
        format.json { render :show, status: :created, location: @recite_task }
      else
        format.html { render :new }
        format.json { render json: @recite_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recite_tasks/1
  # PATCH/PUT /recite_tasks/1.json
  def update
    respond_to do |format|
      if @recite_task.update(recite_task_params)
        format.html { redirect_to @recite_task, notice: 'Recite task was successfully updated.' }
        format.json { render :show, status: :ok, location: @recite_task }
      else
        format.html { render :edit }
        format.json { render json: @recite_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recite_tasks/1
  # DELETE /recite_tasks/1.json
  def destroy
    @recite_task.destroy
    respond_to do |format|
      format.html { redirect_to recite_tasks_url, notice: 'Recite task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recite_task
      @recite_task = ReciteTask.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recite_task_params
      params.require(:recite_task).permit(:task_type, :word_ids, :user_id, :start_time, :next_time)
    end
end
