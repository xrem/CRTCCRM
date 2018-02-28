using System;

namespace CRTCCRM.Model.Entities {
    public class Lead {
        public int Id { get; set; }

        public string Title { get; set; }

        public DateTime CreationDate { get; set; }

        public int TypeId { get; set; }

        public int CategoryId { get; set; }

        public int SourceId { get; set; }

        public int AssignedEmployeeId { get; set; }

        public int LanguageId { get; set; }

        public DateTime? CallbackDate { get; set; }

        public int? RejectionReasonId { get; set; }

        public DateTime? RejectionDate { get; set; }

        public int StatusId { get; set; }

        public bool Deleted { get; set; }

        public int WorkStatusId { get; set; }
    }
}
