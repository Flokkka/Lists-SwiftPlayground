import PlaygroundSupport

let list = List<Int>(elements: [5, 8, 3, 6, 9, 4, 7, 3, 2])
let listView = InteractiveDeleteView(list: list)

PlaygroundPage.current.liveView = listView
