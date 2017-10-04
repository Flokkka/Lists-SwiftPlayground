import PlaygroundSupport

let liveView = MainLiveView<Int>()
let list = List<Int>(elements: [7, 3, 9, 5, 9, 4, 5, 1])

liveView.show(list)
list.remove(element: 3)
liveView.show(list)
list.remove(index: 4)
liveView.show(list)
list.remove(element: 9)
liveView.show(list)

PlaygroundPage.current.liveView = liveView
