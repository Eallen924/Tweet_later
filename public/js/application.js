
$(document).ready(function() {
  $('form').on('submit', function(e){
    e.preventDefault();
    var form = $(this);
    // form.hide();

    var tweet = $(this).find("textarea[name=tweet]").val();
    $("ul").prepend("<li class='posting'>" + tweet + "</li>");
    
    var data = form.serialize();
    form[0].reset();
    // $('#loader').show();
    $.ajax({
      method: 'post',
      url: '/tweet',
      data: data
    }).done(function(response) {
      var jobId = response.job_id;
      displayTweetOnceItsDone(jobId, 500);
    });
  });
});

function displayTweetOnceItsDone(jobId, timeout) {
  // call server endpoint with job_id
  setTimeout(function() {

    $.get("/status/" + jobId).done(function(data) {
      console.log(data);
      if (data.done === true) {

        $("ul li").removeClass("posting");
      } else {

        displayTweetOnceItsDone(jobId, timeout);
      }
    });
  }, timeout);
}
