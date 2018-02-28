using System;

namespace CRTCCRM.Model.Entities {
    public class AssigneHistoryItem {
        public int Id { get; set; }

        public int EmployeeId { get; set; }

        public int LeadId { get; set; }

        public DateTime OperationDate { get; set; }

        public bool IsAssigned { get; set; }

        public bool Deleted { get; set; }
    }
}
