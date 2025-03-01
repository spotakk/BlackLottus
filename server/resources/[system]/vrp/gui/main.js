window.addEventListener("load", function () {
  const wprompt = new WPrompt();

  wprompt.onClose = function () {
    $.post("http://vrp/prompt", JSON.stringify({ act: "close", result: wprompt.result }));
  };

  window.addEventListener("message", function (evt) {
    const data = evt.data;

    if (data.act === "prompt") {
      const { title, text, value } = data;
      wprompt.open(title, text, value);
    }
  });
  const formContents = document.getElementById("FormContents");
  formContents.addEventListener("submit", function (event) {
    event.preventDefault();
    wprompt.close(true);
  });

  formContents.addEventListener("keydown", function (event) {
    if (event.key === "Enter") {
      event.preventDefault();
      wprompt.close(true);
    }
  });

  document.addEventListener("keydown", function (event) {
    if (event.key === "Escape") {
      wprompt.close(false);
    }
  });
});