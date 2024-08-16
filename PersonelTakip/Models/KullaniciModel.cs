namespace PersonelTakip.Models
{
    public class KullaniciModel
    {
        public int pkKullanici { get; set; }
        public string KullaniciAdi { get; set; }
        public string Sifre { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public string EPosta { get; set; }
        public string Telefon { get; set; }
        public int fkYetki { get; set; }
        public bool SifreDegistir { get; set; }
    }
}
