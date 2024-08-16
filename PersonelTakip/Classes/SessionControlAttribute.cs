using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using static PersonelTakip.Classes.PersonelTakipHelper;

public class SessionControlAttribute : ActionFilterAttribute
{
    public override void OnActionExecuting(ActionExecutingContext context)
    {        
        var session = context.HttpContext.Session;
        if (session.GetString(SESSION_NAME) == null)              
            context.Result = new RedirectToActionResult("Giris", "Hesap", null);       

        base.OnActionExecuting(context);
    }
}
