$(document).ready(function () {
    $(".table").DataTable({
      buttons: true,
      dom: '<"row"<"col-md-4"l><"col-md-4"B><"col-md-4"f>><"clear">t<"row"<"col-md-6"i><"col-md-6"p>>',
      buttons: {
        name: "primary",
        buttons: ["copy", "csv", "excel", "pdf", "print"],
      },
    });
  });
  