using System.Collections.Generic;

namespace Requester.Abstractions {
    public interface IRequester {
        IEnumerable<T> Query<T>(string name, string query, object parameters = null);
        void Query(string name, string query, object parameters = null);
    }
}
