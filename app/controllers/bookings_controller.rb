class BookingsController < ApplicationController
  # before_action :find_business, only: [:create]

  def index
    @bookings = Booking.all
  end

  def show
    # raise
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def new
    # raise
    # If redirecting is the better choice
    # redirect_back fallback_location: root_path unless current_user.role == "Contractor"
    @booking = Booking.new
    authorize @booking
  end

  def create
    # initialize new booking
    @chatroom = Chatroom.find(params[:chatroom_id])
    @booking = Booking.new(booking_params)
    @business = Chatroom.find(params[:chatroom_id]).business
    @customer = Chatroom.find(params[:chatroom_id]).customer.id
    @contractor = Chatroom.find(params[:chatroom_id]).contractor.id
    @booking.contractor_id = @contractor
    @booking.business = @business
    @booking.customer_id = @customer
    @booking.user = current_user
    authorize @booking

    if @booking.save!
      redirect_to booking_path(@booking)
    else
      render "businesses/show"
    end
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  private

  def find_business
    @business = Business.find(params[:business_id])
  end

  def booking_params
    params.require(:booking).permit(:price, :start_date, :end_date)
  end
end
