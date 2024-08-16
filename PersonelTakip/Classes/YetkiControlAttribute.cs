using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Http;
using System;
using static PersonelTakip.Classes.PersonelTakipHelper;

namespace PersonelTakip.Classes
{
    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, Inherited = true, AllowMultiple = true)]
    public class YetkiAttribute : Attribute, IAuthorizationFilter
    {
        private readonly string[] _allowedRoles;

        public YetkiAttribute(params string[] allowedRoles)
        {
            _allowedRoles = allowedRoles;
        }

        public void OnAuthorization(AuthorizationFilterContext context)
        {
            var session = context.HttpContext.Session;
            if (session != null)
            {
                var sessionYetki = session.GetInt32(SESSION_YETKI).ToString();
                if (!string.IsNullOrWhiteSpace(sessionYetki))
                {
                    foreach (var allowedRole in _allowedRoles)
                    {
                        if (sessionYetki.Equals(allowedRole.Trim().ToUpper(), StringComparison.OrdinalIgnoreCase))
                            return;
                    }

                }
            }
            context.Result = new RedirectToActionResult("Giris", "Hesap", null);
        }
    }
}
