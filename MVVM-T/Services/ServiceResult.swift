public enum Result <S, E> {
    case success(S)
    case error(E)
}

public typealias ServiceResult = Result<Codable?, String?>

