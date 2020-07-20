import UIKit
import Combine
import Network


public protocol NetworkMonitoring {
    var networkStatusSubject: AnyPublisher<NetworkMonitor.Status, Never> { get }
    
    var isReachable: Bool { get }
}

public final class NetworkMonitor: NetworkMonitoring {
    public enum Status {
        case online
        case offline
    }

    static public let shared = NetworkMonitor()

    private let networkStatusQueue = DispatchQueue(label: "core.network_status_monitoring")
    private let monitor = NWPathMonitor()

    private let networkStatusPublisher = PassthroughSubject<Status, Never>()

    /// Subscribe to newtwork status change notifications
    public let networkStatusSubject: AnyPublisher<Status, Never>

    private var status: Status = .online

    public var isReachable: Bool {
        return status == .online
    }

    private init() {
        networkStatusSubject = networkStatusPublisher.eraseToAnyPublisher()
        
        listenNetworkStatus()
    }
}

// MARK: - Private

private extension NetworkMonitor {
    func listenNetworkStatus() {
        monitor.start(queue: networkStatusQueue)

        monitor.pathUpdateHandler = { [unowned self] val in
            self.status = val.status == .satisfied ? .online : .offline

            self.networkStatusPublisher.send(self.status)
        }
    }
}
