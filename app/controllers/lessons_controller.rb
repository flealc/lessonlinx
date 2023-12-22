class LessonsController < ApplicationController
  include Timezoneable

  before_action :set_lesson, only: %i[ show edit update destroy ]
  before_action :set_student
  before_action except: %i[select_delete bulk_delete] do
    authorize @lesson || Lesson
  end

  # GET /lessons or /lessons.json
  def index
    @q = @student.lessons.default_order.ransack(params[:q])
    @lessons = @q.result(distinct: true)
  end

  # GET /lessons/1 or /lessons/1.json
  def show
    respond_to do |format|
      format.turbo_stream { render partial "lessons/lesson", lesson: @lesson }
      format.html
    end
  end

  # GET /lessons/new
  def new
    @lesson = @student.lessons.new
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: t("create_lesson"), href: "#" },
    ]
  end

  # GET /lessons/1/edit
  def edit
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: t("edit_lesson"), href: "#" },
    ]
    if params[:status] == "canceled"
      @lesson.status = "canceled"
    end
  end

  # POST /lessons or /lessons.json
  def create
    if params[:lesson][:starts_at].blank? || params[:lesson][:duration].blank?
      flash[:alert] = t("lesson_info")
      redirect_to new_student_lesson_url
      return
    end
    @lesson = @student.lessons.new(build_datetimes(lesson_params))

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to student_lessons_url(@student), notice: t("lesson_created") }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    if params[:lesson][:starts_at].blank? || params[:lesson][:duration].blank? || !params[:lesson][:duration].to_i
      flash[:alert] = t("lesson_info")
      redirect_to edit_student_lesson_url
      return
    end
    respond_to do |format|
      if @lesson.update(build_datetimes(lesson_params))
        format.html { redirect_to student_lessons_url(@student), notice: t("lesson_updated") }
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
      format.html { redirect_to student_lessons_url(@student), notice: t("lesson_destroyed") }
      format.json { head :no_content }
    end
  end

  def bulk_new
    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: t("create_lessons"), href: "#" },
    ]
  end

  def bulk_create
    if bulk_params[:starts_at].blank? || bulk_params[:weekdays].blank? || bulk_params[:duration].blank? || bulk_params[:from].blank? || bulk_params[:to].blank?
      flash[:alert] = t("lessons_info")
      redirect_to bulk_new_student_lessons_path
      return
    end
    start_time = Time.parse(bulk_params[:starts_at])
    from_date = Date.parse(bulk_params[:from])
    to_date = Date.parse(bulk_params[:to])
    weekdays = bulk_params[:weekdays]
    duration = bulk_params[:duration]
    lessons_to_create = []

    ActiveRecord::Base.transaction do
      (from_date..to_date).each do |date|
        if weekdays.include?(date.strftime("%A").downcase)
          lesson_starts_at = Time.zone.parse("#{date} #{bulk_params[:starts_at]}")
          lesson = @student.lessons.build(
            starts_at: lesson_starts_at,
            duration: duration,
            teacher_id: current_user.id,
          )

          unless lesson.valid?
            Rails.logger.debug "Invalid lesson: #{lesson.errors.full_messages}"
            raise ActiveRecord::Rollback
          end
          lessons_to_create << lesson
        end
      end

      lessons_to_create.each(&:save!)
    end

    redirect_to student_lessons_url(@student), notice: t("lessons_created")
  rescue ActiveRecord::Rollback
    redirect_to new_bulk_student_lessons_url(@student), alert: t("lessons_error")
  end

  def select_delete
    authorize @student
    @q = @student.lessons.default_order.ransack(params[:q])
    @lessons = @q.result(distinct: true)

    @breadcrumbs = [
      { content: @student.full_name, href: student_lessons_path(@student) },
      { content: t("delete_lessons"), href: "#" },
    ]
  end

  def bulk_delete
    authorize @student

    lesson_ids = params[:lessons]

    if lesson_ids.blank?
      redirect_back(fallback_location: student_lessons_path(@student), alert: t("select_lessons")) 
      return
    end
   
      @lessons = Lesson.where(id: lesson_ids)
    

      begin
        ActiveRecord::Base.transaction do
          @lessons.each(&:destroy!)
        end
        redirect_to student_lessons_url(@student), notice: t("lessons_destroyed")
      rescue ActiveRecord::RecordNotDestroyed => e
        logger.error "Error deleting lessons: #{e.message}"
        redirect_to select_delete_url(@student), alert: t("lessons_delete_error")
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
end
