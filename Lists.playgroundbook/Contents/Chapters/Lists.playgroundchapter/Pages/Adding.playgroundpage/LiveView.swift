import PlaygroundSupport

let liveView = MainLiveView<Int>()
let list = List<Int>()

liveView.show(list)
list.add(9)
liveView.show(list)
list.add(7)
liveView.show(list)
list.add(index: 1, element: 3)
liveView.show(list)

PlaygroundPage.current.liveView = liveView
