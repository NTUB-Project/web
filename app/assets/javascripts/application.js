// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require fancybox
//= require rails-ujs
//= require popper
//= require jquery-ui
//= require bootstrap-sprockets
//= require underscore-min
//= require gmaps/google
//= require_tree .


var bkgrdimg_letters = {};
bkgrdimg_letters.opacityIn = [0,1];
bkgrdimg_letters.scaleIn = [0.2, 1];
bkgrdimg_letters.scaleOut = 3;
bkgrdimg_letters.durationIn = 800;
bkgrdimg_letters.durationOut = 600;
bkgrdimg_letters.delay = 500;

anime.timeline({loop: true})
  .add({
    targets: '.bkgrdimg_letters .letters-1',
    opacity: bkgrdimg_letters.opacityIn,
    scale: bkgrdimg_letters.scaleIn,
    duration: bkgrdimg_letters.durationIn
  }).add({
    targets: '.bkgrdimg_letters .letters-1',
    opacity: 0,
    scale: bkgrdimg_letters.scaleOut,
    duration: bkgrdimg_letters.durationOut,
    easing: "easeInExpo",
    delay: bkgrdimg_letters.delay
  }).add({
    targets: '.bkgrdimg_letters .letters-2',
    opacity: bkgrdimg_letters.opacityIn,
    scale: bkgrdimg_letters.scaleIn,
    duration: bkgrdimg_letters.durationIn
  }).add({
    targets: '.bkgrdimg_letters .letters-2',
    opacity: 0,
    scale: bkgrdimg_letters.scaleOut,
    duration: bkgrdimg_letters.durationOut,
    easing: "easeInExpo",
    delay: bkgrdimg_letters.delay
  }).add({
    targets: '.bkgrdimg_letters .letters-3',
    opacity: bkgrdimg_letters.opacityIn,
    scale: bkgrdimg_letters.scaleIn,
    duration: bkgrdimg_letters.durationIn
  }).add({
    targets: '.bkgrdimg_letters .letters-3',
    opacity: 0,
    scale: bkgrdimg_letters.scaleOut,
    duration: bkgrdimg_letters.durationOut,
    easing: "easeInExpo",
    delay: bkgrdimg_letters.delay
  }).add({
    targets: '.bkgrdimg_letters .letters-4',
    opacity: bkgrdimg_letters.opacityIn,
    scale: bkgrdimg_letters.scaleIn,
    duration: bkgrdimg_letters.durationIn
  }).add({
    targets: '.bkgrdimg_letters .letters-4',
    opacity: 0,
    scale: bkgrdimg_letters.scaleOut,
    duration: bkgrdimg_letters.durationOut,
    easing: "easeInExpo",
    delay: bkgrdimg_letters.delay
  }).add({
    targets: '.bkgrdimg_letters',
    opacity: 0,
    duration: 500,
    delay: 500
  });

//廠商列表篩選
  $(document).ready(function(){
  $(".checkbox_submit").change(function(){
      var src = $(this);
      $.ajax({
        type: "post",
        url: "/grounds/search",
        data: {"region_ids": this.id},
        success: function(result){
          src.parents('form:first').submit();
      }});
  });
});



//各廠商篩選列

function myFunction(x) {
  if (x.matches) { // If media query matches
      $(document).ready(function(){
        $('#mobile').removeClass('container');
        $(".hidesearch").hide();
        //$("#collapseTitle").css();
        
      });
  } else {
    
      $(window).scroll(function(){
        if( $('#searchbar').height()<$('#searchPageRightColumn').height() ){
        
        	if($(this).scrollTop()>$('.activitycontent').offset().top){
        		$('#searchbar').addClass('fixed');
        	}else if( $(this).scrollTop()<$('.activitycontent').offset().top){
        		$('#searchbar').removeClass('fixed');
        	}
        	if( $(window).scrollTop() + $(window).height()>$('.footer').offset().top){
        		 $('#searchbar').removeClass('fixed');
        	}
      	
        };
    });
    
  }
}

  var x = window.matchMedia("(max-width: 1000px)")
  myFunction(x) // Call listener function at run time
  x.addListener(myFunction)
  
  