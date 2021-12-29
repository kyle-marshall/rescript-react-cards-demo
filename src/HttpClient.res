// bindings can be isolated/upstreamed. I'm inlining it just for the example
type request
type response
@new external makeXMLHttpRequest: unit => request = "XMLHttpRequest"
@send external addEventListener: (request, string, unit => unit) => unit = "addEventListener"
@get external response: request => response = "response"
@send external open_: (request, string, string) => unit = "open"
@send external send: request => unit = "send"
@send external abort: request => unit = "abort"
// =========
@scope("JSON") @val
external parseResponse: response => 'a = "parse"

let getJSON = (uri: string, onDone: 'a => (), onError: () => ()) => {
  Js.log(`[GET] ${uri}`);
  let request = makeXMLHttpRequest()
  request->addEventListener("load", () => {
    let response = request->response->parseResponse
    onDone(response)
  })
  request->addEventListener("error", () => {
    onError()
  })
  request->open_("GET", uri)
  request->send
  () => request->abort
}

