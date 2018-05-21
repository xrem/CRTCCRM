using System.Web.Http;

namespace CRTCCRM.Api {
    public static class WebApiConfig {
        public static void Register(HttpConfiguration config) {
            // Web API configuration and services

            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                "DefaultApi",
                "v1/{controller}/{action}",
                new {id = RouteParameter.Optional}
            );
        }
    }
}