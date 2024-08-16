namespace PersonelTakip.Models
{
    public class PersonelModel
    {
        public int pkPersonel { get; set; }
        public string Ad { get; set; }
        public string Soyad { get; set; }
        public char Cinsiyet { get; set; }
        public string ZimmetBilgileri { get; set; }
        public string Universite { get; set; }
        public int fkMezuniyetDurumu { get; set; }
    }
}
