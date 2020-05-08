window.onload = function () {
  document.querySelectorAll("td").forEach(function (td) {
    td.addEventListener("mouseover", function (e) {
      e.currentTarget.style.backgroundColor = "#FFCC99";
    });

    td.addEventListener("mouseout", function (e) {
      e.currentTarget.style.backgroundColor = "";
    });
  });
};
