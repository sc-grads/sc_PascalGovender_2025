namespace Domain
{
    public class Flight
    {
        List<Booking> bookingList = new();
        public IEnumerable<Booking> BookingList => bookingList;
        //private List<Booking> BookingList { get; set; } = new();
        public int SeatCapacity { get; }
        public int RemainingNumberOfSeats { get; private set; }

        public Guid Id { get; } 

        public object? Book(string passengerEmail, int numberOfSeats)
        {
            if (numberOfSeats <= RemainingNumberOfSeats)
            {
                RemainingNumberOfSeats -= numberOfSeats;
                bookingList.Add(new Booking(passengerEmail, numberOfSeats));

                return null;
            }
            else
            {
                return new OverbookingError();
            }
        }

        [Obsolete("Needed by EF")]
        Flight() { }

        public Flight(int seatCapacity)
        {
            SeatCapacity = seatCapacity;
            RemainingNumberOfSeats = seatCapacity;
        }

        public object? CancelBooking(string passengerEmail, int numberOfSeats)
        {
            if(!BookingList.Any(booking=> booking.PassengerEmail == passengerEmail)) {
                return new BookingNotFoundError();
            }

            RemainingNumberOfSeats += numberOfSeats;
            return null;
        }
    }
}
