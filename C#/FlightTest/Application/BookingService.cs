using Data;

namespace Application
{
    public class BookingService
    {
        public Entities Entities { get; set; }

        public BookingService(Entities ent)
        {
            Entities = ent;
        }
        public void Book(BookDto bookDTO)
        {
            var flight = Entities.Flights.Find(bookDTO.FlightId);

            flight.Book(bookDTO.PassengerEmail, bookDTO.NumberOfSeats);

            Entities.SaveChanges();
        }

        public IEnumerable<BookingRm> FindBookings(Guid flightID)
        {
            return Entities.Flights.Find(flightID).BookingList.Select(b =>
                new BookingRm(b.PassengerEmail, b.NumberOfSeats));
        }

        public void CancelBooking(CancelBookingDto c)
        {
            var flight = Entities.Flights.Find(c);
            flight.CancelBooking(c.PassengerEmail, c.NumSeats);
            Entities.SaveChanges();
        }

        public object GetRemainingNumberOfSeatsFor(Guid id)
        {
            return Entities.Flights.Find(id).RemainingNumberOfSeats;
        }
    }
}