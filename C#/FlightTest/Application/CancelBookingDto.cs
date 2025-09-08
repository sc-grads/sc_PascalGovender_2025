using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
    public class CancelBookingDto
    {
        public Guid FlightID { get; set; }
        public string PassengerEmail { get; set; }
        public int NumSeats { get; set; }
        public CancelBookingDto(Guid id, string passengerEmail, int numSeats)
        {
            FlightID = id;
            PassengerEmail = passengerEmail;
            NumSeats = numSeats;
        }
    }
}
