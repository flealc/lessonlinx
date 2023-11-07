class LessonsController < ApplicationController
  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :set_timezone
  before_action :set_student

  # GET /lessons or /lessons.json
  def index
    @q = @student.lessons.default_order.ransack(params[:q])
    @lessons = @q.result(distinct: true)
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    respond_to do |format|
      format.turbo_stream {render partial "lessons/lesson", lesson: @lesson}
      format.html
    end

  end

  # GET /lessons/new
  def new
    @lesson = @student.lessons.new
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: "Create lesson", href: "#" },
    ]
  end

  # GET /lessons/1/edit
  def edit
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: "Edit lesson", href: "#" },
    ]
    if params[:status] == "canceled"
      @lesson.status = "canceled"
    end
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = @student.lessons.new(build_datetimes(lesson_params))

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to student_lessons_url(@student), notice: "Lesson was successfully created." }
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
        format.html { redirect_to student_lessons_url(@student), notice: "Lesson was successfully updated." }
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
      format.html { redirect_to student_lessons_url(@student), notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def bulk_new
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: "Create lesson", href: "#" },
    ]
  end

  # def bulk_create
  #   start_time = Time.parse(bulk_params[:starts_at])
  #   from_date= Date.parse(bulk_params[:from])
  #   to_date = Date.parse(bulk_params[:to])
  #   weekdays = bulk_params[:weekdays]
  #   duration = bulk_params[:duration]

    
  #   (from_date..to_date).each do |date|
  #     if weekdays.include?(date.strftime("%A"))
  #       lesson_starts_at = Time.zone.local_to_utc(DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec))
  #       @student.lessons.create(
  #         starts_at: lesson_starts_at,
  #         duration: duration,
  #         teacher_id: current_user.id
  #       )

  #     end
  #   end
    
  #   redirect_to student_lessons_url(@student), notice: "Lessons were successfully created." 
  # end

  def bulk_create
    start_time = Time.parse(bulk_params[:starts_at])
    from_date = Date.parse(bulk_params[:from])
    to_date = Date.parse(bulk_params[:to])
    weekdays = bulk_params[:weekdays]
    duration = bulk_params[:duration]
    lessons_to_create = []
  
    ActiveRecord::Base.transaction do
      (from_date..to_date).each do |date|
        if weekdays.include?(date.strftime("%A"))
          lesson_starts_at = DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec, Time.zone.formatted_offset)
          lesson = @student.lessons.build(
            starts_at: lesson_starts_at,
            duration: duration,
            teacher_id: current_user.id
          )
         
          raise ActiveRecord::Rollback unless lesson.valid?
          lessons_to_create << lesson
        end
      end
  
      lessons_to_create.each(&:save!)
    end
  
    redirect_to student_lessons_url(@student), notice: "Lessons were successfully created."
  rescue ActiveRecord::Rollback
    redirect_to new_bulk_student_lessons_url(@student), alert: "There was an error creating the lessons."
  end

  def select_delete
    @q = @student.lessons.default_order.ransack(params[:q])
    @lessons = @q.result(distinct: true)
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: "Delete lessons", href: "#" },
    ]
  end
  def bulk_delete
    params.require(:lessons)
    
    if params[:lessons].any?
      @lessons = Lesson.where(id: params[:lessons])
    end

    
    
    if @lessons.delete_all
      redirect_to student_lessons_url(@student), notice: "Lessons were successfully deleted."
    else
      redirect to select_delete_url(@student), alert: "There was an error deleting the lessons."
    end

  end
  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
  end

  def set_student
    @student = Student.find(params[:student_id])

  end

  # Only allow a list of trusted parameters through.
  def lesson_params
    params.require(:lesson).permit(:student_id, :starts_at, :duration, :status, :lesson_notes)
  end

  def bulk_params
    params.require(:bulk).permit(:student_id, :starts_at, :duration, :from, :to, :weekdays => [])
  end

  def set_timezone
    Time.zone = current_user.timezone
  end

  def build_datetimes(lesson_params)
    if lesson_params[:starts_at] && lesson_params[:duration]
      lesson_params[:starts_at] = Time.zone.local_to_utc(DateTime.parse(lesson_params[:starts_at].to_s))
      lesson_params[:ends_at] = lesson_params[:starts_at] + (lesson_params[:duration].to_i.minutes)
    end

    lesson_params[:teacher_id] = current_user.id
    lesson_params
  end
end
