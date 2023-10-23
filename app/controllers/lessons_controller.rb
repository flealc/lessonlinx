class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy ]
  
  # GET /lessons or /lessons.json
  def index
    @lessons = Lesson.all.order(starts_at: :asc)
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = Lesson.new(build_datetimes(lesson_params))
    

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(build_datetimes(lesson_params))
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:student_id, :date, :starts_at, :ends_at, :status, :lesson_notes)
    end

    def build_datetimes(lesson_params)
      
      date = Date.parse(lesson_params[:date].to_s)
      starts = Time.parse(lesson_params[:starts_at].to_s)
      ends = Time.parse(lesson_params[:ends_at].to_s)
     
      student = Student.find(lesson_params[:student_id])

      Time.zone = current_user.timezone

      lesson_params[:starts_at] = Time.zone.local(date.year, date.month, date.day, starts.hour, starts.min, 0)
      lesson_params[:ends_at] = Time.zone.local(date.year, date.month, date.day, ends.hour, ends.min, 0)
      lesson_params[:teacher_id] = current_user.id
      lesson_params[:duration] = lesson_params[:ends_at] - lesson_params[:starts_at]
      lesson_params[:student] = student

      lesson_params.except(:date) 
    end
  
end
