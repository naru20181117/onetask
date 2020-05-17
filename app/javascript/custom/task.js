document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll("td").forEach(function (td) {
    td.addEventListener("mouseover", function (e) {
      e.currentTarget.style.backgroundColor = "#FFCC99";
      e.currentTarget.style.cursor = "pointer";
    });

    td.addEventListener("mouseout", function (e) {
      e.currentTarget.style.backgroundColor = "";
      e.currentTarget.style.cursor = "";
    });
  });
});

document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll(".delete").forEach(function (a) {
    a.addEventListener("ajax:success", function () {
      var td = a.parentNode;
      var tr = td.parentNode;
      tr.style.display = "none";
    });
  });
});
