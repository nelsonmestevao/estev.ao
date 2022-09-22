import { registerChatMessages } from "./messages";
import { registerTopbar } from "./topbar";

export function registerEvents() {
  registerTopbar();
  registerChatMessages();
}
