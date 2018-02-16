using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;

namespace WebApiCache.Controllers
{
    public class HorarioController : ApiController
    {
        //[CacheOutput(ServerTimeSpan = 120)]
        [OutputCache(NoStore = true, Duration = 60, VaryByParam = "*")]
        string Get() { return DateTime.Now.ToString(); }
    }
}