using System;
using System.Data.SqlClient;

namespace Requester.Abstractions {
    public interface IWrappedConnection : IDisposable {
        SqlConnection Connection { get; }
    }
}