using System.Data.SqlClient;
using Requester.Abstractions;

namespace Requester.Implementation {
    public class PerRequestConnectionManager : IConnectionManager {
        private readonly string _connectionString;

        public PerRequestConnectionManager(string connectionString) {
            _connectionString = connectionString;
        }

        public IWrappedConnection CreateWrappedConnection() {
            var connection = new SqlConnection(_connectionString);
            connection.Open();
            return new PerRequestConnection(connection);
        }
    }
}