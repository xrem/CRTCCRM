// ReSharper disable InconsistentNaming
namespace CRTCCRM.Model.Entities {
    public class EmployeeKPI {
        public int Id { get; set; }

        public int EmployeeId { get; set; }

        public int KPIId { get; set; }

        public decimal? ActualValue { get; set; }

        public decimal? PlannedValue { get; set; }
    }
}