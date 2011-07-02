class ReservationMailer < ActionMailer::Base
  default :from => "reservations@culini.de"

  def reservation_confirmation(reservation)
    @reservation = reservation
    mail :to => @reservation.email
  end

end
