// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function select_provider(provider) {
    $.ajax({
        url: "/providers/select",
        type: "GET",
        data: {"provider" : provider},
        dataType: "html",
        success: function(data) {
            window.location.reload();
        }
    });
}
