// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(document).ready(function(){
    $("#search_condition").change(function(){
	if($("#search_condition").val() == "Location"){
	    $("#search_text").attr("id","replace1").attr("name","replace1").css("display","none");
	    $("#replace").attr("id","search_text").attr("name","search_text").css("display","inline");
	}
	else if($("#replace1").size() == 1)
	{
	    $("#search_text").attr("id","replace").attr("name","replace").css("display", "none");
	    $("#replace1").attr("id","search_text").attr("name","search_text").css("display","inline");
	}
    });
});