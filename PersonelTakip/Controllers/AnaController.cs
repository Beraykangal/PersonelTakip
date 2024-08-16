using Microsoft.AspNetCore.Mvc;
using PersonelTakip.Classes;
using PersonelTakip.Models;
using System.Net;
using static PersonelTakip.Classes.PersonelTakipHelper;

namespace PersonelTakip.Controllers
{
    [Route("AnaController/[action]")]
    public class AnaController : Controller
    {
        private readonly ApiService _apiService;
        private readonly UygulamaDbContext _context;

        public AnaController(UygulamaDbContext context, ApiService apiService)
        {
            _context = context;
            _apiService = apiService;
        }

        #region Personeller
        [SessionControl]
        public async Task<IActionResult> Personeller()
        {
            var universiteIsimleri = await _apiService.GetUniversitelerAsync();
            ViewBag.Universiteler = universiteIsimleri;

            var personeller = _context.Personeller.ToList();
            return View(personeller);
        }

        public IActionResult PersonelKaydet([FromBody] PersonelModel model)
        {
            try
            {
                if (model == null || !ModelState.IsValid)
                    return StatusCode((int)HttpStatusCode.BadRequest, new { success = false, message = "Geçersiz model." });

                if (model.pkPersonel == 0)
                    _context.Personeller.Add(model);

                else
                {
                    var secilenPersonel = _context.Personeller.Find(model.pkPersonel);
                    if (secilenPersonel == null)
                        return StatusCode((int)HttpStatusCode.NotFound, new { success = false, message = "Personel bulunamadı." });

                    secilenPersonel.Ad = model.Ad;
                    secilenPersonel.Soyad = model.Soyad;
                    secilenPersonel.Cinsiyet = model.Cinsiyet;
                    secilenPersonel.fkMezuniyetDurumu = model.fkMezuniyetDurumu;
                    secilenPersonel.Universite = model.Universite;
                    secilenPersonel.ZimmetBilgileri = model.ZimmetBilgileri;

                    _context.Personeller.Update(secilenPersonel);
                }

                _context.SaveChanges();
                return Ok(new { success = true, message = "Personel başarıyla kaydedildi." });
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { success = false, message = "Bir hata oluştu: " + ex.Message });
            }
        }

        public IActionResult PersonelSil([FromBody] PersonelModel model)
        {
            try
            {
                if (model.pkPersonel <= 0)
                    return StatusCode((int)HttpStatusCode.BadRequest, new { success = false, message = "Lütfen silinecek personeli seçiniz!" });

                var secilenPersonel = _context.Personeller.Find(model.pkPersonel);
                if (secilenPersonel == null)
                    return StatusCode((int)HttpStatusCode.NotFound, new { success = false, message = "Personel bulunamadı." });

                _context.Personeller.Remove(secilenPersonel);
                _context.SaveChanges();

                return Ok(new { success = true, message = "Personel başarıyla silindi." });
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { success = false, message = "Bir hata oluştu: " + ex.Message });
            }
        }
        #endregion

        #region Kullanicilar
        [SessionControl]
        [Yetki("1")]
        public IActionResult Kullanicilar()
        {
            var kullanicilar = _context.Kullanicilar.ToList();
            return View(kullanicilar);
        }

        public IActionResult KullaniciKaydet([FromBody] KullaniciModel model)
        {
            try
            {
                if (model == null || !ModelState.IsValid)
                    return StatusCode((int)HttpStatusCode.BadRequest, new { success = false, message = "Geçersiz model." });

                if (model.pkKullanici == 0)
                    _context.Kullanicilar.Add(model);

                else
                {
                    var secilenKullanici = _context.Kullanicilar.Find(model.pkKullanici);
                    if (secilenKullanici == null)
                        return StatusCode((int)HttpStatusCode.NotFound, new { success = false, message = "Kullanıcı bulunamadı." });

                    secilenKullanici.Ad = model.Ad;
                    secilenKullanici.Soyad = model.Soyad;
                    secilenKullanici.KullaniciAdi = model.KullaniciAdi;
                    secilenKullanici.Telefon = model.Telefon;
                    secilenKullanici.EPosta = model.EPosta;
                    secilenKullanici.fkYetki = model.fkYetki;
                    secilenKullanici.SifreDegistir = model.SifreDegistir;
                    if (model.Sifre != "")
                        secilenKullanici.Sifre = CreateMD5(model.Sifre);

                    _context.Kullanicilar.Update(secilenKullanici);
                }

                _context.SaveChanges();
                return Ok(new { success = true, message = "Kullanıcı başarıyla kaydedildi." });
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { success = false, message = "Bir hata oluştu: " + ex.Message });
            }
        }

        public IActionResult KullaniciSil([FromBody] KullaniciModel model)
        {
            try
            {
                if (model.pkKullanici <= 0)
                    return StatusCode((int)HttpStatusCode.BadRequest, new { success = false, message = "Lütfen silinecek kullanıcıyı seçiniz!" });

                var secilenKullanici = _context.Kullanicilar.Find(model.pkKullanici);
                if (secilenKullanici == null)
                    return StatusCode((int)HttpStatusCode.NotFound, new { success = false, message = "Kullanıcı bulunamadı." });

                _context.Kullanicilar.Remove(secilenKullanici);
                _context.SaveChanges();

                return Ok(new { success = true, message = "Kullanıcı başarıyla silindi." });
            }
            catch (Exception ex)
            {
                return StatusCode((int)HttpStatusCode.InternalServerError, new { success = false, message = "Bir hata oluştu: " + ex.Message });
            }
        }
        #endregion
    }
}