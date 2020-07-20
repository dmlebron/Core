import Foundation
import UIKit
import Combine

public protocol NotificationsMonitoring {
    var notificationSubject: AnyPublisher<NotificationsMonitor.Notification, Never>! { get }
}

public final class NotificationsMonitor: NotificationsMonitoring {
    public enum Notification: CaseIterable {
        case deviceEnterBackground
        case deviceBecameActive

        fileprivate var notification: NSNotification.Name {
            switch self {
            case .deviceBecameActive:
                return UIApplication.didBecomeActiveNotification

            case .deviceEnterBackground:
                return UIApplication.didEnterBackgroundNotification
            }
        }
    }
    
    static public let shared = NotificationsMonitor()
    
    private let notificationCenter = NotificationCenter.default
    
    /// Subscribe to device enter background / become active change notifications
    private(set) public var notificationSubject: AnyPublisher<Notification, Never>!
    
    private init() {
        listenNotifications()
    }
}

// MARK: - Private

private extension NotificationsMonitor {
    func listenNotifications() {
        notificationSubject = notificationCenter
            .publisher(for: Notification.deviceBecameActive.notification)
            .map { _ in Notification.deviceBecameActive }
            .eraseToAnyPublisher()

        notificationSubject = notificationCenter
            .publisher(for: Notification.deviceEnterBackground.notification)
            .map { _ in Notification.deviceEnterBackground }
            .eraseToAnyPublisher()
    }
}
