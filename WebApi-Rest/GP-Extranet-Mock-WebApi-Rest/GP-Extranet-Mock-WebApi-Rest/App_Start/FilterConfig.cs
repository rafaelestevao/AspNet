using System.Web;
using System.Web.Mvc;

namespace GP_Extranet_Mock_WebApi_Rest
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}
