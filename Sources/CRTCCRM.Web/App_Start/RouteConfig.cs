using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace CRTCCRM.Web
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute("index", "", new {
                controller = "Home",
                action = "Index"
            });
            routes.MapRoute("login", "login", new {
                controller = "Home",
                action = "Login"
            });
            routes.MapRoute("contacts", "contacts", new {
                controller = "Home",
                action = "Contacts"
            });
            routes.MapRoute("createLeads", "createLeads", new {
                controller = "Home",
                action = "CreateLeads"
            });
            routes.MapRoute("editLead", "editLead", new {
                controller = "Home",
                action = "EditLead"
            });
            routes.MapRoute("leads", "leads", new {
                controller = "Home",
                action = "Leads"
            });
            routes.MapRoute("viewLead", "viewLead", new {
                controller = "Home",
                action = "ViewLead"
            });

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Home", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
