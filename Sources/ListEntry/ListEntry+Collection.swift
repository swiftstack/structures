import Foundation

extension ListEntry: BidirectionalCollection {
    public typealias Index = UnsafeMutablePointer<ListEntry<T>>
    public var startIndex: Index {
        var head = self
        return head.next
    }

    public var endIndex: Index {
        var head = self
        return head.originalPointer
    }

    public subscript(position: Index) -> UnsafeMutablePointer<ListEntry<T>> {
        return position
    }

    public func index(after index: Index) -> Index {
        return index.pointee.next
    }

    public func index(before index: Index) -> Index {
        return index.pointee.prev
    }
}
