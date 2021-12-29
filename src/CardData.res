let sampleImageURL = "https://picsum.photos/800/800"

let mockAttNames = [
    "Boops",
    "Zerp",
    "Skizzle",
    "Momo",
    "Lammet",
    "Quaron"
]

let mockAttValues = [
    "Reemble",
    "Flooflam",
    "Mochaco",
    "Leeroy",
    "Oopsilawn",
    "Guardabard",
    "Lixon",
    "Cheelop",
    "Vernt",
    "Zax"
]

let tierChoices = [
    "common",
    "rare",
    "epic",
    "legendary",
]

let getMockAttribute = (name: string): NFT.attribute => {
    name: name,
    value: mockAttValues[Js.Math.random_int(0, Array.length(mockAttValues))],
    tier: tierChoices[Js.Math.random_int(0, tierChoices -> Array.length)],
    percentage: Js.Math.random() *. 100.0
}

let getMockAttributes = (): array<NFT.attribute> => {
    Belt.Array.map(mockAttNames, getMockAttribute)
}

let getMockItem = (): NFT.collectionItem => {
    let id = Js.Math.random_int(0, 100000)
    {
        name: j`ABC # $id`,
        imageURI: sampleImageURL ++ "?" ++ (Js.Math.random_int(0, 100000) |> Belt.Int.toString),
        description: "",
        attributes: getMockAttributes()
    }
}

let getMockItems = (howMany: int) => {
    let items = Belt.Array.map(Belt.Array.range(1, howMany), _ => getMockItem())
    Belt.SortArray.stableSortInPlaceBy(items, (a, b) => a.name == b.name ? 0 : a.name < b.name ? -1 : 1)
    items
} 

module MockClient = {
    let getItems = () => {
        Promise.make((resolve, _reject) => {
            resolve(. getMockItems(10))
        });
    }
}

module MGC = {
    let getNFTsByWallet = () => {
        ()
    }
}