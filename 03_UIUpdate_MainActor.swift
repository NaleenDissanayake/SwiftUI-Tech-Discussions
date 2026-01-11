import Foundation

// MARK: - UI update safety with @MainActor
// In SwiftUI, updating state should happen on the main actor.
// With @MainActor, the compiler helps enforce correctness.

@MainActor
final class UsersViewModel {
    private(set) var users: [String] = []

    func load() async {
        users = await fetchUsers_asyncMock()
        print("Updated users on main thread? \(Thread.isMainThread)")
    }
}

func fetchUsers_asyncMock() async -> [String] {
    try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s
    return ["Sai", "Sushma", "Nishith"]
}

let vm = UsersViewModel()

Task {
    await vm.load()
    print("ViewModel users:", await MainActor.run { vm.users })
}
