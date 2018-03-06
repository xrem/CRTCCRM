using Bogus;
using CRTCCRM.Model.Entities;
using Requester.Implementation;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;

namespace FillDataGenerator {
    static class Program {

        public static readonly DateTime GenerationStartTime = new DateTime(2017, 5, 13);

        public static void Main(string[] args) {
            Console.WriteLine("Started.");
            var iDbCredentials = ConfigurationManager.ConnectionStrings["InternalDatabase"];
            var requester = DapperRequester.Create(iDbCredentials.ConnectionString);
            requester.Query("ConnectionTest", "select 1");
            Console.WriteLine("Connection: OK");
            var faker = new Faker();
            SpawnEmployees(requester, faker);
            FillEmployeesCategories(requester);
            SpawnLeads(requester, faker);

            Console.ReadLine();
        }

        private static void SpawnLeads(DapperRequester requester, Faker faker) {
            Console.Write("Preparting data for lead generation...");
            var enabledContactLanguages = requester.GetAll<Language>().Where(x => x.Enabled).ToList();
            var categories = requester.GetAll<LeadCategory>().Where(x => !x.Deleted).ToList();
            var currentDateTime = GenerationStartTime;
            var workStatuses = requester.GetAll<LeadWorkStatus>();
            var initalWorkStatusId = workStatuses.Single(x => x.Name == "Открыт").Id;
            var leadStatuses = requester.GetAll<LeadStatus>();
            var initalLeadStatusId = leadStatuses.Single(x => x.Name == "Потенциальный клиент").Id;
            var leadSources = requester.GetAll<LeadSource>();
            var leadTypes = requester.GetAll<LeadType>();
            var leadTypesForPeoples = leadTypes.Where(x => x.Type == "Розничный клиент").ToList();
            var leadTypesForCompanies = leadTypes.Except(leadTypesForPeoples).ToList();
            Console.WriteLine("OK");
            while (currentDateTime < DateTime.Now.AddDays(-2)) {
                bool isCompany = faker.Random.Bool();
                var lang = enabledContactLanguages.PickRandom();
                var person = new Person(lang.CultureName.Substring(0, 2));
                var lead = new Lead {
                    SourceId = leadSources.PickRandom().Id,
                    StatusId = initalLeadStatusId,
                    WorkStatusId = initalWorkStatusId,
                    CategoryId = categories.PickRandom().Id,
                    Title = isCompany ? faker.Company.CompanyName() : person.FullName,
                    LanguageId = lang.Id,
                    CreationDate = currentDateTime,
                    TypeId = (isCompany ? leadTypesForCompanies : leadTypesForPeoples).PickRandom().Id
                };
                requester.Insert(lead);
                currentDateTime = currentDateTime
                    .AddDays(faker.Random.Int(0, 2))
                    .AddHours(faker.Random.Int(0, 23))
                    .AddMinutes(faker.Random.Int(10, 55));
            }
        }

        private static void FillEmployeesCategories(DapperRequester requester) {
            var categories = requester.GetAll<LeadCategory>().Where(x => !x.Deleted).ToList();
            var employees = requester.GetAll<Employee>().Where(x => !x.Deleted).ToList();
            foreach (var employee in employees) {
                requester.Insert(new AvailableCategories {
                    CategoryId = categories.Where(x => !x.Deleted).Select(x => x.Id).PickRandom(),
                    EmployeeId = employee.Id
                });
            }
        }

        private static void SpawnEmployees(DapperRequester requester, Faker faker) {
            var positions = requester.Query<EmployeePosition>("GetPositions", "SELECT * FROM [EmployeePosition]").ToList();
            var chefPositionId = positions.Single(x => x.Position == "Руководитель").Id;
            var managerPositionId = positions.Single(x => x.Position == "Менеджер").Id;            
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
                var randomCountOfManagersToAdd = new Randomizer().Int(1, 5);
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
        }
    }
}
