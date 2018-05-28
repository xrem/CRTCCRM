using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using CRTCCRM.Api.Models;
using CRTCCRM.Model.Entities;

namespace CRTCCRM.Api.Controllers {
    public class EmployeesController : BaseController
    {
        [HttpGet]
        public IEnumerable<EmployeeVM> GetEmployees(string searchQuery = "") {
            var searchStr = searchQuery.ToLower();
            var notDeletedEmployees = _requester.GetAll<Employee>()
                .Where(x => !x.Deleted)
                .ToList();
            var employeesDict = notDeletedEmployees
                .ToDictionary(x => x.Id, x => x);
            var positions = _requester.GetAll<EmployeePosition>()
                .ToDictionary(x => x.Id, x => x.Position);
            return notDeletedEmployees.Where(x => 
                    string.IsNullOrWhiteSpace(searchStr)
                    || string.IsNullOrEmpty(searchStr)
                    || x.Name.ToLower().Contains(searchStr)
                    || x.Surname.ToLower().Contains(searchStr)
                    || x.Login.ToLower().Contains(searchStr))
                .Select(x => new EmployeeVM() {
                Id = x.Id,
                DisplayName = $"{x.Surname} {x.Name}",
                Login = x.Login,
                Online = x.Online,
                Position = positions[x.PositionId],
                Chef = x.ChefId.HasValue 
                    ? $"{employeesDict[x.ChefId.Value].Surname} {employeesDict[x.ChefId.Value].Name}" 
                    : "Has no chef"
            });
        }

        [HttpPost]
        public AuthVM AuthEmployee(string login, string password) {
            var hash = SHA1Util.SHA1HashStringForUTF8String(password);
            var emp = _requester.Query<Employee>("AuthEmployee",
                "SELECT * FROM [Employee] WHERE login = @login and password = @hash",
                new {
                    login = login,
                    hash = hash
                }).SingleOrDefault();
            return new AuthVM() {
                Success = emp != null,
                Token = emp != null ? "apiKey" : null
            };
        }
    }
}