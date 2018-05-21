using System.Collections.Generic;
using System.Linq;
using System.Web.Http;
using CRTCCRM.Model.Entities;

namespace CRTCCRM.Api.Controllers {
    public class PackagesController : BaseController {
        public PackagesController() : base() { }

        [HttpGet]
        public IEnumerable<Internet> GetInternet() {
            return _requester.GetAll<Internet>().Where(x => !x.Deleted);
        }

        [HttpGet]
        public IEnumerable<Television> GetTelevision() {
            return _requester.GetAll<Television>().Where(x => !x.Deleted);
        }
    }
}