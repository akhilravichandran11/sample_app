class ConfroombookingsController < ApplicationController
  before_action :runvariables

 
  
  def new
    @confroombooking=Confroombooking.new
  end
  
  
   def create
     
    params[:confroombooking]["user_id"]=@cuser[:id]
    
    iyear= params[:confroombooking]["bdate(1i)"].to_i
    ## imonth=Date::MONTHNAMES.index(params[:confroombooking]["bdate(2i)"].to_s) 
    imonth=params[:confroombooking]["bdate(2i)"].to_i
    iday= params[:confroombooking]["bdate(3i)"].to_i
    
    params[:confroombooking]["bday"]=iday
    params[:confroombooking]["bmonth"]=imonth
    params[:confroombooking]["byear"]=iyear
    params[:confroombooking]["roomstatus"]="true"
    params[:confroombooking]["roomstatusreason"]="New"
    
    
   @confroombooking=Confroombooking.new(confroombooking_params)
    if @confroombooking.save
      flash[:success] = " Created  Booking "
     redirect_to confroombookings_path
    else 
     ## flash[:danger] = " Not Created  Booking "
      render :new
    end

  end
  
  
  def show
   @confroombooking = Confroombooking.find(params[:id])
    
  end

  def index
    @confroombookings=Confroombooking.all
  end

  def destroy
    Confroombooking.find(params[:id]).destroy
    flash[:success] = "Booking Deleted"
    redirect_to confroombookings_path
  end

  def edit
   @confroombooking = Confroombooking.find(params[:id])
  end
  
  def update
    @confroombooking = Confroombooking.find(params[:id])
    iyear= params[:confroombooking]["bdate(1i)"].to_i
    imonth=params[:confroombooking]["bdate(2i)"].to_i
    iday= params[:confroombooking]["bdate(3i)"].to_i
    
    params[:confroombooking]["bday"]=iday
    params[:confroombooking]["bmonth"]=imonth
    params[:confroombooking]["byear"]=iyear
    params[:confroombooking]["roomstatus"]="true"
    params[:confroombooking]["roomstatusreason"]="Edit"
    
   
  if @confroombooking.update_attributes(confroombooking_params_update)
    flash[:success] = "Booking Updated"
    redirect_to confroombookings_path
  else
    ##flash[:danger] = "Booking Not Updated"
    render :edit
  end
  end
  
      
     def runvariables
     @cmintimes=[0,5,10,15,20,25,30,35,40,45,50,55]
     @chourtimes=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
     @crooms=Room.all
     @cusers = User.all
     @cuser = User.find(session[:user_id])
     ##@cuser = User.find(session[:user_id])
    ##@cmintimes=["00","05","10","15","20","25","30","35","40","45","50","55"]
    ##@chourtimes=["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
   
     end
    
  
   
private


  def confroombooking_params
      params.require(:confroombooking).permit(:user_id, :room_id, :roomstatus, :roomstatusreason , :stHour, :stMin , :enHour , :enMin , :bday , :bmonth , :byear , :bdate)
  end
  
   def confroombooking_params_update
      params.require(:confroombooking).permit(:roomstatus, :roomstatusreason , :stHour, :stMin , :enHour , :enMin , :bday , :bmonth , :byear , :bdate)
  end
  
  
   def confroombooking_paramsnull
      if params[:confroombooking].nil?  || params[:confroombooking].empty?
        return true
      end
   end
  
  def confroombooking_params2
    if params[:confroombooking].nil?  || params[:confroombooking].empty?
        return false
    else
        params.require(:confroombooking).permit(:user_id, :room_id, :roomstatus, :roomstatusreason , :stHour, :stMin , :enHour , :enMin , :bday , :bmonth , :byear , :bdate)
    end
end
  
end
