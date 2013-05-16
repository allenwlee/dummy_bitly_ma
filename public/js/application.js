$(document).ready(function() {
  $("#enter_url").on('submit', function(e){
    e.preventDefault();
    $.ajax({
      type: 'post',
      url: '/urls',
      data: $('#enter_form').serialize()
    }).done( function(data){
      $('#enter_form').fadeOut(500);
      $('#enter_form').parent().append("<a href='/" + data + "'>" + data + "</a>");
      $('h2').text("Your New URL!");
    });    
  });

  $("#login").on('click', function(e){
    e.preventDefault();
  });    
    






});

