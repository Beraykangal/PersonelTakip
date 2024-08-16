using System.ComponentModel.DataAnnotations;

namespace PersonelTakip.Models
{
    public class KullaniciGirisModel
    {
        [Required(ErrorMessage = "Kullanıcı adı zorunlu bir alan!")]
        public string KullaniciAdi { get; set; }

        [Required(ErrorMessage = "Şifre zorunlu bir alan!")]
        [DataType(DataType.Password)]
        public string Sifre { get; set; }
    }
}
