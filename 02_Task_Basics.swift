import Foundation

// MARK: - Modern style: async/await + Task
// Benefits:
// - Linear code
// - Integrates with Swift concurrency
// - Can be cancelled (structured)

func fetchUsers_asyncMock() async -> [String] {
    try? await Task.sleep(nanoseconds: 1_000_000_000) // 1s
    return ["Naleen", "Priyanthe", "Nishith"]
}

print("Start (Task)")

Task {
    let users = await fetchUsers_asyncMock()
    print("Users (Task) on main thread? \(Thread.isMainThread)")
    print("Users:", users)
}
