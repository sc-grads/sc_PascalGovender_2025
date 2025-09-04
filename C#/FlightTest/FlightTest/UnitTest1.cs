using Domain;
using FluentAssertions;


namespace FlightTest
{
    public class UnitTest1
    {
        [Theory]
        [InlineData(3, 1, 2)]
        [InlineData(6, 3, 3)]
        [InlineData(10, 6, 4)]
        public void Booking_reduces_number_of_seats(int seatCap, int numSeats, int remainSeats)
        {
            var flight = new Flight(seatCapacity: seatCap);
            flight.Book("pascal@gmail.com", numSeats);

            flight.RemainingNumberOfSeats.Should().Be(remainSeats);
        }

        [Fact]
        public void AvoidOverbooking()
        {
            var flight = new Flight(seatCapacity: 3);

            var error = flight.Book("john@gmail.com", 4);

            error.Should().BeOfType<OverbookingError>();
        }

        [Fact]
        public void Book_flights_successfully()
        {
            var flight = new Flight(seatCapacity: 3);
            var error1 = flight.Book("jack@gmail.com", 1);
            error1.Should().BeNull();
        }

        [Fact]
        public void Remembers_bookings()
        {
            var flight = new Flight(seatCapacity: 150);
            flight.Book("pascal@gmail.com", 4);


            flight.BookingList.Should().ContainEquivalentOf(new Booking("pascal@gmail.com", 4));
        }

        [Theory]
        [InlineData(150, 4, 4, 150)]
        [InlineData(150, 10, 5, 145)]
        public void CancelBooking_free_seats(int initialCap, int numSeats, int numCancel, int remainingSeats)
        {
            var flight = new Flight(seatCapacity: 150);
            flight.Book("pascal@gmail.com", numSeats);
            flight.CancelBooking("pascal@gmail.com", numCancel);
            flight.RemainingNumberOfSeats.Should().Be(remainingSeats);
        }

        [Fact]
        public void Doesnt_cancel_booking_for_passengers_who_havent_booked()
        {
            var flight = new Flight(seatCapacity: 150);
            var error = flight.CancelBooking(passengerEmail: "john@gmail.com", numberOfSeats: 1);
            error.Should().BeOfType<BookingNotFoundError>();
        }

        [Fact]
        public void Returns_null_when_cancelling_existing_booking()
        {
            var flight = new Flight(seatCapacity: 150);
            flight.Book("pascal@gmail.com", 4);
            var error = flight.CancelBooking("pascal@gmail.com", 4);
            error.Should().BeNull();
        }
    }
}
