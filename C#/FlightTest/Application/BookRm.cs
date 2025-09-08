using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Application
{
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
