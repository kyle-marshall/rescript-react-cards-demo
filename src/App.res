open Promise

module CardCollectionViewer = {
  @react.component
  let make = (~items: array<NFT.collectionItem>) => {
    let (selectedIndex, setSelectedIndex) = React.useState(_ => -1)
    let (selectedIsFlipped, setSelectedIsFlipped) = React.useState(_ => false)

    let onCardClick = React.useCallback1((e: ReactEvent.Mouse.t, index: int) => {
      // gobble up the event
      ReactEvent.Mouse.stopPropagation(e)
      if index == selectedIndex {
        setSelectedIsFlipped(p => !p)
      } else {
        setSelectedIndex(_ => index)
        setSelectedIsFlipped(_ => false)
      }
    }, [selectedIndex])

    let onContainerClick = React.useCallback((_: ReactEvent.Mouse.t) => {
      setSelectedIndex(_ => -1)
      setSelectedIsFlipped(_ => false)
    })

    <div className="collection-container" onClick=onContainerClick>
      <div className="m-card-spread">
        {Belt.Array.mapWithIndex(items, (i, item) => {
          let {name, imageURI, description, attributes} = item
          let selected = selectedIndex == i
          let extraClass = if selected {
            "m-card-selected"
          } else {
            ""
          }
          <Card
            extraClass
            key={Belt.Int.toString(i)}
            frontTitle=name
            backTitle=name
            imageSrc=imageURI
            description={React.string(description)}
            backContent={<AttributeList attributes />}
            flipped={selected && selectedIsFlipped}
            onClick={e => onCardClick(e, i)}
          />
        })->React.array}
      </div>
    </div>
  }
}

type getAttributesResponse = {
    attributes: array<NFT.attribute>
}

let testURI = "https://homunculi.org:9999/api/rarity-mon/check/mysticgirlsclub/3984"

// the main App component
@react.component
let make = () => {
  let (items, setItems) = React.useState(_ => [])

  React.useEffect0(() => {
    CardData.MockClient.getItems()
    ->then(fetchedItems => {
      setItems(_ => fetchedItems)
      resolve()
    })
    ->ignore
    let cancel = HttpClient.getJSON(testURI, (atts: getAttributesResponse) => {
      Js.log(atts)
    }, () => ())
    Some(cancel)
  })

  <CardCollectionViewer items />
}
