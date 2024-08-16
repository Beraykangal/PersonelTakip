using Microsoft.EntityFrameworkCore;
using PersonelTakip.Models;

namespace PersonelTakip.Classes
{
    public class UygulamaDbContext : DbContext
    {
        public UygulamaDbContext(DbContextOptions<UygulamaDbContext> options)
            : base(options)
        {
        }

        public DbSet<KullaniciModel> Kullanicilar { get; set; }
        public DbSet<PersonelModel> Personeller { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<KullaniciModel>()
                .HasKey(k => k.pkKullanici);

            modelBuilder.Entity<PersonelModel>()
             .HasKey(k => k.pkPersonel);
        }
    }
}
