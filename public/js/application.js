
$(document).ready(function() {
  $('form').on('submit', function(e){
    e.preventDefault();
    var form = $(this);
    var tweet = $(this).find("textarea[name=tweet]").val();
   
    // $("ul").prepend("<li class='posting'>" + tweet + "</li>");
    var tweetClone = $('.tweet_container').first().clone();
    tweetClone.find('#tweet_body').text(tweet);
    tweetClone.addClass("posting")
    $('.container').prepend(tweetClone);

    var data = form.serialize();
    console.log('serialize the form data');
    console.log(data);
    form[0].reset();
    $.ajax({
      method: 'post',
      url: '/tweet',
      data: data
    }).done(function(response) {
      var jobId = response.job_id;
      console.log('Made it to done with ajax post')
      console.log(jobId);
      displayTweetOnceItsDone(jobId, 500);
    });
  });
});

function displayTweetOnceItsDone(jobId, timeout) {
  setTimeout(function() {

    $.get("/status/" + jobId).done(function(data) {

      console.log('I\'m inside the displayTweetOnceItsDone function');
      console.log(data);
      if (data.done === true) {

        $('.tweet_container').removeClass("posting");
      } else {

        displayTweetOnceItsDone(jobId, timeout);
      }
    });
  }, timeout);
}
