using Domain;
using FluentAssertions;


namespace FlightTest
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {
            var flight = new Flight(seatCapacity:3);
            flight.Book("pascal@gmail.com",1);

            flight.RemainingNumberOfSeats.Should().Be(2);
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
    }
}
