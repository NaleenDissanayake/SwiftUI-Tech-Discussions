import Foundation

// MARK: - "Legacy" style: GCD / DispatchQueue
// Key pain points:
// - Manual hop back to main queue
// - No structured cancellation
// - Harder to compose with async/await

func fetchUsers_syncMock() -> [String] {
    // Pretend this is expensive work
    Thread.sleep(forTimeInterval: 1.0)
    return ["Naleen", "Priyanthe", "Nishith"]
}

print("Start (DispatchQueue)")

DispatchQueue.global().async {
    let users = fetchUsers_syncMock()

    DispatchQueue.main.async {
        print("Users (DispatchQueue) on main thread? \(Thread.isMainThread)")
        print("Users:", users)
    }
}
