using System;
using System.Data;
using System.Data.SqlClient;
using Requester.Abstractions;

namespace Requester.Implementation {
    public class PerRequestConnection : IWrappedConnection {
        private readonly SqlConnection _conection;
        public bool IsDisposed { get; private set; }

        public PerRequestConnection(SqlConnection connection) {
            _conection = connection ?? throw new ArgumentNullException("connection");
        }

        // ReSharper disable once ConvertToAutoPropertyWhenPossible
        public SqlConnection Connection => _conection;

        public void Dispose() {
            if (IsDisposed)
                return;

            IsDisposed = true;
            if (_conection.State != ConnectionState.Broken && _conection.State != ConnectionState.Closed) {
                _conection.Dispose();
            }
        }        
    }
}