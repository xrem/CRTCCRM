namespace CRTCCRM.Model.Entities {
    public class LeadPackage {
        public int Id { get; set; }

        public int PackageId { get; set; }

        public int LeadId { get; set; }

        public bool Deleted { get; set; }
    }
}