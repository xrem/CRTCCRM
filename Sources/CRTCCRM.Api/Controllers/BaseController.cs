using System.Configuration;
using System.Web.Http;
using Requester.Implementation;

namespace CRTCCRM.Api.Controllers {
    public abstract class BaseController : ApiController {
        protected readonly DapperRequester _requester;

        public BaseController() {
            var iDbCredentials = ConfigurationManager.ConnectionStrings["InternalDatabase"];
            _requester = DapperRequester.Create(iDbCredentials.ConnectionString);
        }
    }
}