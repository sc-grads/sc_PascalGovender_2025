using FluentAssertions;
using Data;
using Domain;
using Microsoft.EntityFrameworkCore;

namespace Application.Tests
{
    public class FlightApplicationSpecifications
    {
        [Fact]
        public void Books_flghts()
        {
            var entities = new Entities(new DbContextOptionsBuilder<Entities>()
                .UseInMemoryDatabase("Flights")
                .Options);
            var flight = new Flight(3);
            entities.Flights.Add(new Flight(3));

            var bookingService = new BookingService(entities);

            bookingService.Book(new BookDto(flight.Id,"a@b.com",2));
            bookingService.FindBookings(flight.Id).Should().ContainEquivalentOf(new BookingRm("a@b.com", 2));
        }
    }

    public class BookingService
    {
        public BookingService(Entities ent)
        {
            
        }
        public void Book(BookDto bookDTO)
        {

        }

        public IEnumerable<BookingRm> FindBookings(Guid flightID)
        {
            return new[]
            {
                new BookingRm("a@b.com", 2)
            };
        }
    }

    public class BookDto
    {
        public BookDto(Guid flightId,string passengeEmail, int numSeats)
        {
            
        }
    }

    public class BookingRm
    {
        public string PassengerEmail { get; }
        public int NumberOfSeats { get; }

        public BookingRm(string pEmail, int numSeats)
        {
            PassengerEmail = pEmail;
            NumberOfSeats = numSeats;
        }
    }
}
