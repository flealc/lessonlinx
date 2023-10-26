class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy student_lessons ]

  # GET /students or /students.json
  def index
    @students = Student.all
  end

  # GET /students/1 or /students/1.json
  def show
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  # GET /students/new
  def new
    @student = Student.new
    render "students/new"
  end

  
  # GET /students/1/edit
  def edit
  end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)
    @student.teacher_id = current_user.id

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
        format.turbo_stream #do
        #   render turbo_stream: [
        #            turbo_stream.update(
        #              "students-list",
        #              partial: "students/students_list",
        #            ),
        #            turbo_stream.update(
        #              "student-details",
        #              partial: "students/student",
        #              locals: { student: @student },
        #            ),
        #          ]
        # end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
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

  def student_lessons
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:first_name, :last_name, :age, :adult, :lessons_count, :student_notes)
  end
end
