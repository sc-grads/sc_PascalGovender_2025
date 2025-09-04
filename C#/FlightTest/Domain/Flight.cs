namespace Domain
{
    public class Flight
    {
        public int SeatCapacity { get; }
        public int RemainingNumberOfSeats { get; private set; }
        public object? Book(string passengerEmail, int numberOfSeats)
        {
            if (numberOfSeats <= RemainingNumberOfSeats)
            {
                RemainingNumberOfSeats -= numberOfSeats;
                return null;
            }
            else
            {
                return new OverbookingError();
            }
        }
        public Flight(int seatCapacity)
        {
            SeatCapacity = seatCapacity;
            RemainingNumberOfSeats = seatCapacity;
        }
    }
}
