﻿using System.Web.Mvc;

namespace CRTCCRM.Api.Controllers {
    public class HomeController : Controller {
        public ActionResult Index() {
            ViewBag.Title = "Home Page";

            return View();
        }
    }
}