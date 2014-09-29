class EmployeesController < ApplicationController
  before_filter :authorize, :only => [:destroy, :edit, :update, :search]
  
  def new
    @employee = Employee.new
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @employee = Employee.new(employee_params)
    respond_to do |format|
      if @employee.save
        flash[:notice] = "Your account has been successfully created. Please login"
        format.html { redirect_to login_path }
      else
        flash[:alert] = @employee.errors.full_messages.join(", ")
        format.html { render action: "new" }
      end
    end
  end
  
  def edit
    @employee = Employee.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:id])
    respond_to do |format|
      if @employee.update_attributes(employee_params)
        format.html { redirect_to :action => "show", :name => @employee.name , notice: 'Employee was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def search
    if request.post?
      @employees = Employee.where( [ "name LIKE ?" , "#{params[:name]}%" ] )
    end
    
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @employee = Employee.find_by_name(params[:name])
    
    respond_to do |format|
      format.html
    end
  end
  
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_path }
    end
  end
  
  private
    def employee_params
      params.require(:employee).permit(:name, :title, :phone, :passwd, :passwd_confirmation, :description, :image)
    end
  
  
end
