using Bogus;
using CRTCCRM.Model.Entities;
using Requester.Implementation;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace FillDataGenerator {
    static class Program {
        public static void Main(string[] args) {
            Console.WriteLine("Started.");
            var iDbCredentials = ConfigurationManager.ConnectionStrings["InternalDatabase"];
            var requester = DapperRequester.Create(iDbCredentials.ConnectionString);
            requester.Query("ConnectionTest", "select 1");
            Console.WriteLine("Connection: OK");
            var positions = requester.Query<EmployeePosition>("GetPositions","SELECT * FROM [EmployeePosition]").ToList();
            var chefPositionId = positions.Single(x => x.Position == "Руководитель").Id;
            var managerPositionId = positions.Single(x => x.Position == "Менеджер").Id;
            var faker = new Faker();
            var chefAccountWithPassword = new List<string>();
            Console.Write($"Adding some chefs...");
            for (var i = 1; i <= 10; i++) {
                var personContext = new Person();
                var rawPassword = faker.Internet.Password(new Randomizer().Int(6, 20));
                var chef = new Employee {
                    Name = personContext.FirstName,
                    Login = personContext.UserName,
                    Password = SHA1Util.SHA1HashStringForUTF8String(rawPassword),
                    Surname = personContext.LastName,
                    PositionId = chefPositionId
                };
                requester.Insert(chef);
                chefAccountWithPassword.Add($"Login: {chef.Login}   Password: {rawPassword}");
            }
            var chefsIds = requester.GetAll<Employee>().Where(x => x.PositionId == chefPositionId).Select(x => x.Id).ToList();
            Console.WriteLine(" OK");
            Console.Write($"Adding some managers...");
            var managerAccountWithPassword = new List<string>();
            var managers = new List<Employee>();
            foreach (var chefId in chefsIds) {
                var randomCountOfManagersToAdd = new Randomizer().Int(1,5);
                for (var i = 0; i < randomCountOfManagersToAdd; i++) {
                    var personContext = new Person();
                    var rawPassword = faker.Internet.Password(new Randomizer().Int(6, 20));
                    var employee = new Employee {
                        Name = personContext.FirstName,
                        Login = personContext.UserName,
                        Password = SHA1Util.SHA1HashStringForUTF8String(rawPassword),
                        Surname = personContext.LastName,
                        PositionId = managerPositionId,
                        ChefId = chefId
                    };
                    managers.Add(employee);
                    managerAccountWithPassword.Add($"Login: {employee.Login}   Password: {rawPassword}");
                }
            }
            requester.InsertCollection(managers);
            Console.WriteLine(" OK");
            Console.WriteLine();
            Console.WriteLine("Random manager accounts for testing:");
            foreach (var s in managerAccountWithPassword.PickRandom(3)) {
                Console.WriteLine(s);
            }
            Console.WriteLine();
            Console.WriteLine("Random chef accounts for testing:");
            foreach (var s in chefAccountWithPassword.PickRandom(3)) {
                Console.WriteLine(s);
            }
            Console.ReadLine();
        }
    }
}
