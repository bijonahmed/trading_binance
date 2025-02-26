$(document).ready(function () {
    $('.btn_sidebar').click(function () {
        $('.dashboard_sidebar').toggleClass("show");
    })
})

// $(document).ready(function () {
//     $('#myButton').click(function () {
//         $('#inactiveDiv').toggle();
//         $('#activeDiv').toggle();
//     });
// });
function toggleButton() {
    var button = document.getElementById("myButton");
    button.classList.toggle("active");
  }