using System;
using System.Collections.Generic;
using Dapper;
using Requester.Abstractions;
// ReSharper disable InvokeAsExtensionMethod

namespace Requester.Implementation {
    public class DapperRequester : IRequester {
        private readonly IConnectionManager _connectionManager;

        public DapperRequester(IConnectionManager connectionManager) {
            _connectionManager = connectionManager;
        }

        public static DapperRequester Create(string connectionString) {
            return new DapperRequester(new PerRequestConnectionManager(connectionString));
        }

        public IEnumerable<T> Query<T>(string name, string query, object parameters = null) {
            try {
                using (var wrapperConnection = _connectionManager.CreateWrappedConnection()) {
                    var result = SqlMapper.Query<T>(wrapperConnection.Connection, query, parameters);
                    return result;
                }
            } catch (Exception ex) {
                //log ex.
                throw new Exception("Something went wrong.");
            }
        }

        public void Query(string name, string query, object parameters = null) {
            try {
                using (var wrapperConnection = _connectionManager.CreateWrappedConnection()) {
                    SqlMapper.Execute(wrapperConnection.Connection, query, parameters);
                }
            } catch (Exception ex) {
                //log ex.
                throw new Exception("Something went wrong.");
            }
        }
    }
}
