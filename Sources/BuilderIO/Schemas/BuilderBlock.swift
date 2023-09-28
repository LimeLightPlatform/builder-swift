import SwiftyJSON

// Schema for Builder blocks
public struct BuilderBlock: Codable {
    var id: String
    var properties: [String: String]? = [:]
    var bindings: [String: String]? = [:]
    var children: [BuilderBlock]? = []
    var component: BuilderBlockComponent? = nil
    var responsiveStyles: BuilderBlockResponsiveStyles? = BuilderBlockResponsiveStyles() // for inner style of the component
}

public struct BuilderBlockComponent: Codable {
    var name: String
    var options: JSON? = [:]
}

public struct BuilderBlockResponsiveStyles: Codable {
    var large: [String: String]? = [:]
    var medium: [String: String]? = [:]
    var small: [String: String]? = [:]
}
