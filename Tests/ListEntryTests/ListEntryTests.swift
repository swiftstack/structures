import Test
@testable import ListEntry

class ListEntryTests: TestCase {
    func testList() {
        let head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        head.deallocate()
    }

    func testEmpty() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        expect(head.isEmpty)

        let c = Container(id: 1)
        expect(c.entry.isEmpty)

        head.insert(c.entry)
        expect(!c.entry.isEmpty)
    }

    func testInitialization() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let container = Container(id: 1)

        head.insert(container.entry)

        expect(head.next == container.entry)
        expect(head.prev == container.entry)
        expect(container.entry.next == head)
        expect(container.entry.prev == head)

        expect(head.next.pointee.payload == container.id)
    }

    func testInsert() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let first = Container(id: 1)
        let second = Container(id: 2)
        head.insert(first.entry)
        head.insert(second.entry)

        expect(head.next == second.entry)
        expect(head.next.next == first.entry)

        expect(head.prev == first.entry)
        expect(head.prev.prev == second.entry)

        expect(head.next.payload == 2)
        expect(head.prev.payload == 1)
    }

    func testAppend() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let first = Container(id: 1)
        let second = Container(id: 2)
        head.append(first.entry)
        head.append(second.entry)

        expect(head.next == first.entry)
        expect(head.next.next == second.entry)

        expect(head.prev == second.entry)
        expect(head.prev.prev == first.entry)

        expect(head.next.payload == 1)
        expect(head.prev.payload == 2)
    }

    func testRemove() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let container = Container(id: 1)

        head.insert(container.entry)

        expect(!head.isEmpty)
        expect(!container.entry.isEmpty)

        container.entry.remove()

        expect(head.isEmpty)
        expect(container.entry.isEmpty)
    }

    func testFirst() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        expect(head.first == nil)

        let items = [Container](head: head, count: 2)
        defer { items.deallocate() }

        guard let first = head.first else {
            fail("first item is nil")
            return
        }
        expect(first.payload == 1)
    }

    func testLast() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        expect(head.last == nil)

        let items = [Container](head: head, count: 2)
        defer { items.deallocate() }

        guard let last = head.last else {
            fail("last item is nil")
            return
        }
        expect(last.pointee.payload == 2)
    }

    func testRemoveFirst() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let items = [Container](head: head, count: 2)
        defer { items.deallocate() }

        let removedFirst = head.removeFirst()
        let removedSecond = head.removeFirst()

        expect(removedFirst.pointee.payload == 1)
        expect(removedSecond.pointee.payload == 2)
        expect(head.isEmpty)
    }

    func testRemoveLast() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let items = [Container](head: head, count: 2)
        defer { items.deallocate() }

        let removedSecond = head.removeLast()
        let removedFirst = head.removeLast()

        expect(removedSecond.pointee.payload == 2)
        expect(removedFirst.pointee.payload == 1)
        expect(head.isEmpty)
    }

    func testPopFirst() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let items = [Container](head: head, count: 10)
        defer { items.deallocate() }

        var id = 0
        while let item = head.popFirst() {
            id += 1
            expect(item.pointee.payload == id)
        }

        expect(id == 10)
        expect(head.isEmpty)
    }

    func testPopLast() {
        var head = UnsafeMutablePointer<ListEntry>.allocate(payload: 0)
        defer { head.deallocate() }
        let items = [Container](head: head, count: 10)
        defer { items.deallocate() }

        var id = 10
        while let item = head.popLast() {
            expect(item.pointee.payload == id)
            id -= 1
        }

        expect(id == 0)
        expect(head.isEmpty)
    }
}
