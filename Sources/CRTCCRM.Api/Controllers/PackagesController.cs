using CRTCCRM.Api.Models;
using CRTCCRM.Model.Entities;
using System.Collections.Generic;
using System.Linq;
using System.Web.Http;

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

        [HttpGet]
        public IEnumerable<PackageVM> GetPackages() {
            var packages =_requester.GetAll<Package>()
                .Where(x => !x.Deleted)
                .ToList();
            var tv = _requester.GetAll<Television>().ToDictionary(x => x.Id, x => x); ;
            var inet = _requester.GetAll<Internet>().ToDictionary(x => x.Id, x => x);
            return packages.Select(x => new PackageVM() {
                PackageId = x.Id,
                InternetPackage = inet[x.InternetId].Name,
                TelevisionPackage = tv[x.TelevisionId].Name
            });
        }
    }
}