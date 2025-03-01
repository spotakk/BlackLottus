function WPrompt(){
    this.div = document.createElement("div");
    this.div.classList.add("wPrompt");
    this.div_contents = document.createElement("form");
		this.div_contents.id = "FormContents";
    this.div_contents.classList.add("contents");
    this.div_title = document.createElement("h1");
    this.div_text = document.createElement("h2");
    this.div_area = document.createElement("textarea");
    this.div_button = document.createElement("button");
		this.div_button.id = "sendResult"
    this.div_button.innerHTML = "ENVIAR FORMULÁRIO"
    this.div.style.display = "none";
    this.div_contents.appendChild(this.div_title);
    this.div_contents.appendChild(this.div_text);
    this.div_contents.appendChild(this.div_area);
    this.div_contents.appendChild(this.div_button);
    this.div.appendChild(this.div_contents);
		document.body.appendChild(this.div);
    this.opened = false
}

WPrompt.prototype.open = function(title,text,value){
    this.div_title.innerHTML = title;
    this.div_text.innerHTML = text;
		this.div_area.value = value !== undefined && value !== null ? value : "";
    this.div.style.display = "inline";
    this.opened = true;

}

WPrompt.prototype.close = function(value){
  this.result = false
  if(this.opened){
    if(value) {
      this.result =  this.div_area.value == "" ? false : this.div_area.value ;
    }
	}
  this.onClose();
  this.div_area.blur();
  this.opened = false;
  this.div.style.display = "none";
}