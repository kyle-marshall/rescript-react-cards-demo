
@react.component
let make = (~attributes: array<NFT.attribute>) => {
  <ul className="attribute-list">
    {Belt.Array.map(attributes, att => {
      let className = "trait " ++ att.tier
      <li className key={att.name}> {React.string(att.name ++ ": ")} {React.string(att.value)} </li>
    })->React.array}
  </ul>
}
