// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import {
  Socket
} from "phoenix"
class App {
  static init() {
    var username = $("#username")
    var msgBody = $("#message")
    var $messages = $("#messages")

    let socket = new Socket("/socket")
    socket.connect()
    socket.onClose(e => console.log("Closed connection"))

    var channel = socket.channel("rooms:lobby", {})

    channel.join()
      .receive("ignore", () => console.log("Auth error"))
      .receive("ok", () => console.log("join ok"))
      
    channel.onError(e => console.log("something went wrong", e))
    channel.onClose(e => console.log("channel closed", e))

    msgBody.off("keypress")
      .on("keypress", e => {
        if (e.keyCode == 13) {
          console.log(`[${username.val()}] ${msgBody.val()}`)
          channel.push("new:msg", {
            user: username.val(),
            body: msgBody.val()
          })
          msgBody.val("")
        }
      })

    channel.on("new:msg", msg => {
      console.log(msg.body)
      $messages.append(this.messageTemplate(msg))
      scrollTo(0, document.body.scrollHeight)
    })
  }

  static sanitize(html) { return $("<div/>").text(html).html() }
  
  static messageTemplate(msg) {
    let username = this.sanitize(msg.user || "anonymous")
    let body = this.sanitize(msg.body)
    if (username != 'SYSTEM')
      return(`<p><a href='#'>[${username}]</a>&nbsp; ${body}</p>`)
  }
}

$(() => App.init())

export default App