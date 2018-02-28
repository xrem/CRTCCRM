using System;

namespace CRTCCRM.Model.Entities {
    public class ContactHistoryItem {
        public int Id { get; set; }

        public int EmployeeId { get; set; }

        public int ContactId { get; set; }

        public string Context { get; set; }

        public DateTime ContactDate { get; set; }

        public bool Deleted { get; set; }
    }
}