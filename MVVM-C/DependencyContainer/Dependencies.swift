import Foundation

class Dependencies {
    
    static private(set) var shared = Dependencies()
    fileprivate var dependencies = [Dependency]()
    
    @_functionBuilder struct DependencyBuilder {
        static func buildBlock(_ dependency: Dependency) -> Dependency { dependency }
        static func buildBlock(_ dependencies: Dependency...) -> [Dependency] { dependencies }
    }
    
    convenience init(@DependencyBuilder _ dependencies: () -> [Dependency]) {
        self.init()
        dependencies().forEach { register($0) }
    }
    
    convenience init(@DependencyBuilder _ dependency: () -> Dependency) {
        self.init()
        register(dependency())
    }
}


extension Dependencies {
    
    func register(_ dependency: Dependency) {
        guard dependencies.firstIndex(where: { $0.name == dependency.name }) == nil else {
            debugPrint("\(String(describing: dependency.name)) already registered, let's ignore")
            return
        }
        dependencies.append(dependency)
    }
    
    func build() {
        for index in dependencies.startIndex..<dependencies.endIndex {
            dependencies[index].resolve()
        }
        Self.shared = self
    }
    
    func resolve<T>() -> T {
        guard let dependency = dependencies.first(where: { $0.value is T })?.value as? T else {
            fatalError("Can't resolve \(T.self)")
        }
        return dependency
    }
    
    func clear() {
        if dependencies.count > 0 {
            dependencies.removeAll()
        }
    }
}
