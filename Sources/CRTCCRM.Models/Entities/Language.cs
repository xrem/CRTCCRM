namespace CRTCCRM.Model.Entities {
    public class Language {
        public int Id { get; set; }

        public string CultureName { get; set; }

        public string DisplayName { get; set; }

        public int CultureCode { get; set; }

        public string Iso639Code { get; set; }

        public bool Enabled { get; set; }
    }
}