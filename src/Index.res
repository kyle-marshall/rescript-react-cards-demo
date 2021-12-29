exception NoRoot

switch ReactDOM.querySelector("#root_react_element") {
    | Some(root) => ReactDOM.render(<App />, root)
    | None => raise(NoRoot)
}
