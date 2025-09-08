using FluentAssertions;
using Data;
using Domain;
using Microsoft.EntityFrameworkCore;
using Application.Tests;


namespace Application.Tests
{
    public class FlightApplicationSpecifications
    {
        readonly Entities entities = new Entities(new DbContextOptionsBuilder<Entities>()
                .UseInMemoryDatabase("Flights")
                .Options);

        readonly BookingService bookingService;
        public FlightApplicationSpecifications()
        {
            bookingService = new BookingService(entities);

        }

        [Theory]
        [InlineData("M@m.com",2)]
        [InlineData("a@s.com",2)]
        public void Books_flghts(string passEmail,int numSeats)
        {

            var flight = new Flight(3);

            entities.Flights.Add(flight);

            
            bookingService.Book(new BookDto(flight.Id,passEmail,numSeats));
            bookingService.FindBookings(flight.Id).Should().ContainEquivalentOf(
                new BookingRm(passEmail, numSeats));
        }


        [Theory]
        [InlineData(3)]
        public void Cancels_booking(int initialCapacity)
        {
            //Given

            var flight = new Flight(3);
            entities.Flights.Add(flight);

            bookingService.Book(new BookDto(flight.Id, "m@m.com", 2));

            //When
            bookingService.CancelBooking(new CancelBookingDto(
                Guid.NewGuid(),
                "m@m.com",
                2));
            bookingService.GetRemainingNumberOfSeatsFor(flight.Id).Should().Be(initialCapacity);
        }
    }
}
