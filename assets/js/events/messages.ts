import Hooks from "../hooks";

export function registerChatMessages() {
  window.addEventListener("phx:page-loading-start", (_info) =>
    Hooks.ChatMessages.handleMessages()
  );
}
