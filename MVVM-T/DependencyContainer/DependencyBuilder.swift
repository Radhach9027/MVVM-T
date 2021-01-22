@_functionBuilder struct DependencyBuilder {
    static func buildBlock(_ dependency: Dependency) -> Dependency { dependency }
    static func buildBlock(_ dependencies: Dependency...) -> [Dependency] { dependencies }
}
