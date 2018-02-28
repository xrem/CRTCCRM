namespace CRTCCRM.Model.Entities {
    public class Employee {
        public int Id { get; set; }

        public string Name { get; set; }

        public string Surname { get; set; }

        public int PositionId { get; set; }

        public string Login { get; set; }

        public string Password { get; set; }

        public int? ChefId { get; set; }

        public bool Online { get; set; }

        public bool Deleted { get; set; }
    }
}