namespace CRTCCRM.Model.Entities {
    public class Contact {
        public int Id { get; set; }

        public int LeadId { get; set; }

        public int ContactTypeId { get; set; }

        public string ContactPerson { get; set; }

        public string ContactData { get; set; }

        public bool Deleted { get; set; }
    }
}