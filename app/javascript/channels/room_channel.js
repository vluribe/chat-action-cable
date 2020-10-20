import consumer from "./consumer"

document.addEventListener("turbolinks:load", ()=>{
  let url = window.location.pathname;
  url = url.substring(1).split("/");
  if(url[0]==="rooms" && url[1]){
    const messages = document.getElementById("room-messages");
    messages.scrollTop = messages.scrollHeight;
    const user_id = document.getElementById("user-info").getAttribute("key");
    consumer.subscriptions.create({channel:"RoomChannel", room_id:url[1], user_id: user_id}, {
      connected() {
        console.log(`Conected to channel: ${url[1]}`)
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        console.log(data);
        const messages = document.getElementById("room-messages");
        messages.innerHTML = messages.innerHTML + data.html;
        messages.scrollTop = messages.scrollHeight;
      }
    });
  }
})
