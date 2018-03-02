using System;
using System.Collections.Generic;
using System.Linq;
using Dapper;
using Dapper.Contrib;
using Dapper.Contrib.Extensions;
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

        public void Insert<T>(T entity) where T : class {
            try {
                SqlMapperExtensions.TableNameMapper = t => t.Name;
                using (var wrapperConnection = _connectionManager.CreateWrappedConnection()) {
                    wrapperConnection.Connection.Insert(entity);
                }
            } catch (Exception ex) {
                //log ex.
                throw new Exception("Something went wrong.");
            }
        }

        public void InsertCollection<T>(IEnumerable<T> entities) where T : class {
            try {
                foreach (var entity in entities) {
                    Insert(entity);
                }
            } catch (Exception ex) {
                //log ex.
                throw new Exception("Something went wrong.");
            }
        }

        public List<T> GetAll<T>() where T : class {
            try {
                SqlMapperExtensions.TableNameMapper = t => t.Name;
                using (var wrapperConnection = _connectionManager.CreateWrappedConnection()) {
                    return wrapperConnection.Connection.GetAll<T>().ToList();
                }
            } catch (Exception ex) {
                //log ex.
                throw new Exception("Something went wrong.");
            }
        }
    }
}
