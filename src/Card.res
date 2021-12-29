@react.component
let make = (
  ~frontTitle: string,
  ~backTitle: string,
  ~imageSrc: string,
  ~description: React.element,
  ~backContent: React.element,
  ~flipped: bool,
  ~onClick: ReactEvent.Mouse.t => unit,
  ~extraClass: string=""
) => {
  let classes = ["m-card"]

  if (flipped) { classes->Js.Array2.push("m-card-flipped")->ignore }
  switch extraClass {
    | "" => ()
    | c => classes->Js.Array2.push(c)->ignore
  }

  let containerClass = classes->Js.Array2.joinWith(" ")

  <div className=containerClass onClick>
    <div className="m-card-inner">
      <div className="m-card-front">
        <div className="m-card-title"> {React.string(frontTitle)} </div>
        <div className="m-card-image-frame"> <img src=imageSrc /> </div>
        <div className="m-card-info"> description </div>
      </div>
      <div className="m-card-back">
        <div className="m-card-title"> {React.string(backTitle)} </div>
        <div className="m-card-back-content"> backContent </div>
      </div>
    </div>
  </div>
}
