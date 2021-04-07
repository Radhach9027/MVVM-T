import Foundation

public protocol DependenciesProtocol {
    func register(_ dependency: Dependency)
    func build()
    func resolve<T>() -> T
    func clear()
}

public class Dependencies {
    
    static private(set) var shared = Dependencies()
    fileprivate var dependencies = [Dependency]()
    
    public convenience init(@DependencyBuilder _ dependencies: () -> [Dependency]) {
        self.init()
        dependencies().forEach { register($0) }
    }
    
    public convenience init(@DependencyBuilder _ dependency: () -> Dependency) {
        self.init()
        register(dependency())
    }
}


extension Dependencies: DependenciesProtocol{
    
    public func register(_ dependency: Dependency) {
        guard dependencies.firstIndex(where: { $0.name == dependency.name }) == nil else {
            debugPrint("\(String(describing: dependency.name)) already registered, let's ignore")
            return
        }
        dependencies.append(dependency)
    }
    
    public func build() {
        for index in dependencies.startIndex..<dependencies.endIndex {
            dependencies[index].resolve()
        }
        Self.shared = self
    }
    
    public func resolve<T>() -> T {
        guard let dependency = dependencies.first(where: { $0.value is T })?.value as? T else {
            fatalError("Can't resolve \(T.self)")
        }
        return dependency
    }
    
    public func clear() {
        if dependencies.count > 0 {
            dependencies.removeAll()
        }
    }
}
