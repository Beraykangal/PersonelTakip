using Microsoft.AspNetCore.Mvc;
using PersonelTakip.Classes;
using PersonelTakip.Models;
using static PersonelTakip.Classes.PersonelTakipHelper;

namespace PersonelTakip.Controllers
{
    
    public class HesapController : Controller
    {
        private readonly UygulamaDbContext _context;

        public HesapController(UygulamaDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Giris()
        {
            return View();
        }

        [HttpPost]
        public IActionResult Giris(KullaniciGirisModel model)
        {
            if (ModelState.IsValid)
            {
                var kullanici = _context.Kullanicilar
                    .FirstOrDefault(u => u.KullaniciAdi == model.KullaniciAdi && u.Sifre == CreateMD5(model.Sifre));

                if (kullanici != null)
                {
                    HttpContext.Session.SetString(SESSION_NAME, HttpContext.Session.Id);
                    HttpContext.Session.SetInt32(SESSION_YETKI, kullanici.fkYetki);                   

                    return RedirectToAction("Personeller", "Ana");
                }

                else
                    ViewBag.ErrorMessage = "Geçersiz giriş bilgileri.";
            }

            return View(model);
        }
    }
}
