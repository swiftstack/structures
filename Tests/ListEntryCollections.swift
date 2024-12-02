import Testing
@testable import ListEntry

@Test("Sequence")
func sequence() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    let items = [Container](head: head, count: 10)
    defer { items.deallocate() }

    var i = 0
    for item in head.pointee {
        i += 1
        #expect(item.pointee.payload == i)
    }

    #expect(i == 10)
}

@Test("Collection")
func collection() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    let items = [Container](head: head, count: 10)
    defer { items.deallocate() }

    var i = 0
    var index = head.pointee.startIndex
    while index != head.pointee.endIndex {
        i += 1
        #expect(head.pointee[index].pointee.payload == i)
        index = head.pointee.index(after: index)
    }

    #expect(i == 10)
}

@Test("BidirectionalCollection")
func bidirectionalCollection() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    let items = [Container](head: head, count: 10)
    defer { items.deallocate() }

    var i = 10
    var index = head.pointee.index(before: head.pointee.endIndex)
    while index != head.pointee.endIndex {
        #expect(head.pointee[index].pointee.payload == i)
        index = head.pointee.index(before: index)
        i -= 1
    }

    #expect(i == 0)
}

@Test("EmptySequence")
func emptySequence() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    var i = 0
    for _ in head.pointee {
        i += 1
    }

    #expect(i == 0)
}

@Test("EmptyCollection")
func emptyCollection() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    var i = 0
    for _ in head.pointee.indices {
        i += 1
    }

    #expect(i == 0)
}

@Test("Count")
func count() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    let items = [Container](head: head, count: 10)
    defer { items.deallocate() }

    #expect(head.count == 10)
}

@Test("Slice")
func slice() async throws {
    let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
    defer { head.deallocate() }

    let items = [Container](head: head, count: 10)
    defer { items.deallocate() }

    var slice = items.prefix(upTo: items.count)

    var id = 10
    while let last = slice.popLast() {
        #expect(last.id == id)
        id -= 1
    }

    #expect(id == 0)
    #expect(slice.isEmpty)
    #expect(!head.isEmpty)
}
