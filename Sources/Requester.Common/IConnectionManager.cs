namespace Requester.Abstractions {
    public interface IConnectionManager {
        IWrappedConnection CreateWrappedConnection();
    }
}