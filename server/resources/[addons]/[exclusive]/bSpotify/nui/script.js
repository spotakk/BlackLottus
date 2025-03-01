let play = true;

$(document).on("input", "input[type=range]", () => {
  const value = $("input[type=range]").val();

  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action: "volume",
      value,
    })
  );
});

$(".pause").click(() => {
  const action = play ? "pause" : "play";

  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action,
    })
  );

  $(".pause").html(
    action === "pause"
      ? `<span class="iconify" data-icon="material-symbols:play-arrow"></span>`
      : `<span class="iconify" data-icon="material-symbols:pause"></span>`
  );
  play = !play;
});

$(".back").click(function () {
  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action: "back",
    })
  );
});

$(".forward").click(function () {
  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action: "forward",
    })
  );
});

const regexYoutubeUrl = "^(https?://)?((www.)?youtube.com|youtu.be)/.+$";
var vidname = "Name not Found";
let loadingSearch = false;

$("header button").click(() => {
  const inputValue = $(".input__container input").val();
  if (inputValue.match(regexYoutubeUrl)) {
    LoadingSearch(true);
    searchUrl(inputValue);
    setTimeout(() => {
      LoadingSearch(false);
    }, 500);
    $(".input__container input").val("");
  }
});

function LoadingSearch(state) {
  loadingSearch = state;

  $("header button").prop("disabled", loadingSearch);
  $("header button").html(
    loadingSearch
      ? `<span class="iconify" data-icon="eos-icons:loading"><span/>`
      : "BUSCAR"
  );
}

window.addEventListener("message", function (event) {
  switch (event.data.action) {
    case "showRadio":
      $("body").show();
      showTime();
      break;
    case "hideRadio":
      $("body").hide();
      break;
    case "changetextv":
      $("input[type=range]").val(event.data.text);
      break;
    case "isPlaying":
      play = event.data.value;
      $(".pause").html(
        play &&
          `<span class="iconify" data-icon="material-symbols:pause"></span>`
      );
      break;
    case "changevidname":
      searchContinues(event.data.text);
      break;
    case "TimeVid":
      getTime(event.data.total, event.data.played);
      break;
  }
});

function getTime(totaltime, timeplayed) {
  timeplayed - 1;
  if (totaltime != undefined && timeplayed != undefined) {
    $(".progress").css("width", (timeplayed * 100) / totaltime + "%");
    $(".controlls_time ul .startTime").html(secondsToHms(timeplayed));
    $(".controlls_time ul .endTime").html(secondsToHms(totaltime));
  } else {
    $(".controlls_time ul .startTime").html("0:00");
    $(".controlls_time ul .endTime").html("0:00");
  }
}

function clearVideo() {
  $(".progress").css("width", "0");
  $(".controlls_time ul .startTime").html("0:00");
  $(".controlls_time ul .endTime").html("0:00");

  $(".media__video").css("background-image", "");
  $(".controlls_media .title").html("");
}

function secondsToHms(d) {
  d = Number(d);
  var h = Math.floor(d / 3600);
  var m = Math.floor((d % 3600) / 60);
  var s = Math.floor((d % 3600) % 60);

  var hDisplay = h > 0 ? h + ":" : "";
  var mDisplay = m > 0 ? m + ":" : "0:";
  var sDisplay = "00";
  if (s > 0) {
    sDisplay = s;
    if (s < 10) {
      sDisplay = "0" + s;
    }
  }
  return hDisplay + mDisplay + sDisplay;
}

function searchContinues(url) {
  playUrl(url);
}

function extractYouTubeVideoId(url) {
  var regExp =
    /^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:embed\/|watch\?v=|v\/)|youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(?:\S+)?$/;
  var match = url.match(regExp);
  if (match && match[1]) {
    return match[1];
  } else {
    return null;
  }
}

function searchUrl(url) {
  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action: "seturl",
      link: url,
    })
  );

  playUrl(url);
}

function playUrl(url) {
  $.getJSON(
    "https://noembed.com/embed?url=",
    { format: "json", url: url },
    function (data) {
      if (data.author_name) {
        fetch(
          `https://www.googleapis.com/youtube/v3/search?part=snippet&type=channel&q=${data.author_name}&key=AIzaSyAfWREjdBVjrWwatl0_Zxw5bgbSEIqIl08`
        )
          .then((e) => e.json())
          .then((data) => {
            $(".controlls_volume_media").show();
            $(".controlls_buttons").show();
            $(".perfil .title").html(data.items[0].snippet.title);
            $(".perfil .photo").css(
              "background-image",
              `url(${data.items[0].snippet.thumbnails.high.url})`
            );
          });
      }

      if (data.thumbnail_url) {
        $(".media__video").css(
          "background-image",
          `url(https://img.youtube.com/vi/${extractYouTubeVideoId(
            url
          )}/sddefault.jpg)`
        );
      }

      if (data.title) {
        $(".controlls_media .title").html(data.title);
      }
    }
  );
}

var doispontos = false;

function showTime() {
  var date = new Date();
  var h = date.getHours(); // 0 - 23
  var m = date.getMinutes(); // 0 - 59
  var session = " AM";

  if (h == 0) {
    h = 12;
  }

  if (h > 12) {
    h = h - 12;
    session = " PM";
  }

  h = h < 10 ? "0" + h : h;
  m = m < 10 ? "0" + m : m;
  var time = h + ":" + m + session;
  if (!doispontos) {
    doispontos = true;
    time = h + " " + m + session;
  } else {
    doispontos = false;
  }
  if ($("body").is(":visible")) {
    setTimeout(showTime, 1000);
  }
}
$(document).ready(function () {
  $(".controlls_volume_media").hide();
  $(".controlls_buttons").hide();
  $("body").hide();
  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post(
        "https://bSpotify/action",
        JSON.stringify({
          action: "exit",
        })
      );
    }
  };
});

$(".input__container").click(() => {
  $(".input__container input").focus();
});

$(".close").click(() => {
  $.post(
    "https://bSpotify/action",
    JSON.stringify({
      action: "exit",
    })
  );
});
