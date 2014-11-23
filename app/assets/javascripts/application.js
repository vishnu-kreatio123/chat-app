// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe('/news/new', function (data) {
       // alert(data);
        var count = parseInt($('#notification_count').text());
        var new_count = count + 1
        $('#notification_count').text(new_count);
       // var user = "<%= session[:user_name].id if session[:user_name]%>";
       // console.log(user);
        ajax_for_notification_update();

    });
});

function ajax_for_notification_update(){
    $.ajax({
        url : '/notification_refresh',
        type : 'POST',
        dataType : 'html',
        //data : 'data=' + user,
        beforeSend: function(xhr){
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
        },
        success : function(update) {
            $('#notification_ajax').html(update);
        }

    })

}


$(document).ready(function()
{
    $("#notificationLink").click(function()
    {
        $("#notification_ajax").fadeToggle(300);
        // $("#notification_count").fadeOut("slow");
    });

//Document Click hiding the popup
    $(document).click(function()
    {
        $("#notificationContainer").hide();
    });

//Popup on click
    $("#notificationContainer").click(function()
    {
        return false;
    });

});