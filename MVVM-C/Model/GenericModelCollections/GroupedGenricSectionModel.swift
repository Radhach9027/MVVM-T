import Foundation

struct GroupedGenricSectionModel<SectionItem : Hashable, RowItem> {
    var sectionItem : SectionItem
    var rows : [RowItem]
    static func group(headlines : [RowItem], by criteria : (RowItem) -> SectionItem) -> [GroupedGenricSectionModel<SectionItem, RowItem>] {
        let groups = Dictionary(grouping: headlines, by: criteria)
        return groups.map(GroupedGenricSectionModel.init(sectionItem:rows:))
    }
}

