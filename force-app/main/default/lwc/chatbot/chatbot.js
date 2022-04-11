import { LightningElement,track } from 'lwc';

export default class ChatbotExample extends LightningElement {
  chatForm = false;
  minForm = false;
  @track message =[];
  input;
  newInput;

//$function(){
//  var arrow = $('.chat-head img');
//  var textarea = $('.chat-text textarea');
   
//  arrow.on('click', function(){
//    var src = arrow.attr('src');

//    $('.chat-body').slideToggle('fast');
//    if(src == 'https://maxcdn.icons8.com/windows10/PNG/16/Arrows/angle_down-16.png'){
//      arrow.attr('src', 'https://maxcdn.icons8.com/windows10/PNG/16/Arrows/angle_up-16.png');
//    }
//    else{
//     arrow.attr('src', 'https://maxcdn.icons8.com/windows10/PNG/16/Arrows/angle_down-16.png');
//    }
//  });

    actionFrom(){
       this.minForm = true;
    }

    closeIcon(){
       this.chatForm = true;
   }


arr = [
    //0 
    ["hi", "hey", "hello"],
    //1
    ["how are you", "how are things"],
    //2
    ["what is going on", "what is up"],
    //3
    ["happy", "good", "well", "fantastic", "cool"],
    //4
    ["bad", "bored", "tired", "sad"],
    //5
    ["tell me story", "tell me joke"],
    //6
    ["thanks", "thank you"],
    //7
    ["bye", "good bye", "goodbye"],
    //8
    ["good morning","good evening","good night"]
    ];
    
     reply = [
    //0 
    ["Hello!", "Hi!", "Hey!", "Hi there!"], 
    //1
    [
        "Fine... how are you?",
        "Pretty well, how are you?",
        "Fantastic, how are you?"
      ],
    //2
    [
        "Nothing much",
        "Exciting things!"
      ],
    //3
    ["Glad to hear it"],
    //4
    ["Why?", "Cheer up buddy"],
    //5
    ["What about?", "Once upon a time..."],
    //6
    ["You're welcome", "No problem"],
    //7
    ["Goodbye", "See you later"],
    ["good morning","good evening","good night"]
    ];
    
    alternative = [
      "Same",
      "Go on...",
      "Try again",
      "I'm listening...",
      "Bro..."
    ];

changeAction(event){
    this.input = event.target.value;

}

buttonAction(){
    this.newInput = this.input;
    this.input = this.input.toLowerCase();
var input1='';
    for (var x = 0; x < this.arr.length; x++) {
        for (var y = 0; y < this.reply.length; y++) {
          if (this.arr[x][y] == this.input) {
            input1 = this.reply[x][y];
           
          }
        }
      }
      if(input1 == ''){
      
    }else{
      this.message.push({
        question : this.newInput,
        Answer : input1
    });
}
}
 

//  textarea.keypress(function(event) {
//    var $this = $(this);

//    if(event.keyCode == 13){
//      var msg = $this.val();
//      $this.val('');
//      $('.msg-insert').prepend("<div class='msg-send'>"+msg+"</div>");
//      }
//  });
//  }
}