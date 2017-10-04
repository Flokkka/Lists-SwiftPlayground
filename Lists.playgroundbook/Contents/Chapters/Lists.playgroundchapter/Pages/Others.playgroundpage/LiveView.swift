import PlaygroundSupport

let liveView = MainLiveView<Int>()
let list = List<Int>(elements: [4, 6, 3, 2, 5, 8])

liveView.show(list)

PlaygroundPage.current.liveView = liveView
