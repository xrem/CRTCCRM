using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CRTCCRM.Model.Entities;

namespace CRTCCRM.Api.Controllers
{
    public class ContactsController : BaseController
    {
        [HttpGet]
        public IEnumerable<Contact> GetContacts() {
            var contacts = _requester.GetAll<Contact>()
                .Where(x => !x.Deleted);
            return contacts;
        }
    }
}