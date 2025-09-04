using Domain;
using Microsoft.EntityFrameworkCore;

namespace Data
{
    public class Entities : DbContext
    {
        public  DbSet<Flight> Flights=> Set<Flight>();

        public Entities(DbContextOptions options): base(options)
        {
            
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Flight>(entity =>
            {
                entity.HasKey(f => f.Id);
            });

            base.OnModelCreating(modelBuilder);
        }
    }
}
