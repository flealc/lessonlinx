class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy recent_lessons student_lessons ]
  before_action { authorize @student || Student }

  # GET /students or /students.json
  def index
    if current_user.students.any?
      redirect_to student_path(current_user.students.first)
    end
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
    @breadcrumbs = [
      { content: "Students", href: students_path },
      { content: "Add student", href: "#" },
    ]
  end

  # GET /students/1/edit
  def edit
    @breadcrumbs = [
      { content: @student.full_name, href: student_path(@student) },
      { content: "Edit student", href: "#" },
    ]
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    @student.teacher_id = current_user.id
    @breadcrumbs = [
      { content: "Students", href: students_path },
      { content: "Add student", href: "#" },
    ]

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    @breadcrumbs = [
      { content: "Students", href: students_path },
      { content: "Add student", href: "#" },
    ]
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def recent_lessons
    @recent_lessons = @student.lessons.past.limit(5)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "recent_lessons_frame",
          partial: "students/recent_lessons",
          locals: { recent_lessons: @recent_lessons },
        )
      end
    end
  end

  def student_lessons
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    begin
      @student = Student.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to students_path, alert: "The requested student record has already been deleted!" 
      return
    end
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :age, :adult, :lessons_count, :student_notes)
  end
end
