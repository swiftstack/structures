@testable import ListEntry

func allocateList(head: UnsafeMutablePointer<ListEntry<Int>>, count: Int) -> [UnsafeMutablePointer<Container>] {
    var items = [UnsafeMutablePointer<Container>]()
    for i in 1...count {
        let container = UnsafeMutablePointer<Container>.allocate(capacity: 1)
        container.initialize(to: Container(id: i))
        head.pointee.append(UnsafeMutablePointer(&container.pointee.entry))
        items.append(container)
    }
    return items
}

func deallocateList(items: [UnsafeMutablePointer<Container>]) {
    for item in items {
        item.pointee.entry.remove()
        item.deallocate(capacity: 1)
    }
}
