class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]
  

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
    @contact.student_id = params[:student]
    @contact.student = Student.find(params[:student])
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params.except(:default))

    respond_to do |format|
      if @contact.save
        check_contact_default
        format.html { render "students/show", locals: { :@student => @contact.student}, data: {turbo_frame: "student-details"} }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
     check_contact_default
      if @contact.update(contact_params.except(:default))
        format.html { render "students/show", locals: { :@student => @contact.student}, data: {turbo_frame: "student-details"} }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy

    if @contact.default?
      @contact.student.update(default_contact_id: nil)
    end
    @contact.destroy

    respond_to do |format|
      format.html { render "students/show", locals: { :@student => @contact.student}, data: {turbo_frame: "student-details" } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :student_id, :phone, :email, :address, :relationship, :preferred_communication_method, :notes, :default)
    end

    def check_contact_default
      @contact.student.set_default_contact(@contact) if contact_params[:default] == "1"
      @contact.student.update(default_contact_id: nil) if contact_params[:default] == "0" && @contact.default?
      
    end

end
