using System;

namespace CRTCCRM.Model.Entities {
    public class UnavailabilityCalendar {
        public int Id { get; set; }

        public int EmployeeId { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public bool Deleted { get; set; }

        public bool? Approved { get; set; }

        public DateTime? ApprovedDate { get; set; }

        public int? ApprovedBy { get; set; }
    }
}