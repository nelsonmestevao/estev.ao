// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";

import Hooks from "./hooks";
import { LiveSocket } from "phoenix_live_view";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { registerEvents } from "./events";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

// Register global event handlers
registerEvents();

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
