const ChatMessages = {
  mount() {
    this.handleMessages();
  },

  updated() {
    this.handleMessages();
  },

  handleMessages() {
    const messages = document.getElementsByClassName("chat-message");
    messages[messages.length - 1].scrollIntoView();
  },
};

export default ChatMessages;
