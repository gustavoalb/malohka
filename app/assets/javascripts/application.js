// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// require turbolinks
//= require jquery
//= require jquery_ujs
//= require moment
//= require twitter/bootstrap
//= require ckeditor/init
//= require fullcalendar
//= require jquery_nested_form
//= require best_in_place
//= require best_in_place.purr
//= require jquery.purr
//= require_tree .

//teste

//teste

jQuery(function($){
 $(".data").mask("99/99/9999");
 $(".datatime").mask("99/99/9999 99:99:99");
 $(".fone").mask("(99) 99999-9999");
 $(".cep").mask("99999-999");
 $(".cpf").mask("999.999.999-99");
 $(".cpfl").mask("99999999999");
}); 


$('myTab1 a[href="#profile"]').tab('show') // Select tab by name
$('#empauta a:first').tab('show') // Select first tab
$('#myTab a:last').tab('show') // Select last tab
$('#myTab li:eq(2) a').tab('show') // Select third tab (0-indexed

// datepicker
// $(function () {
//   $('#datetimepicker1').datetimepicker();
// });
// $(function () {
//   $('#datetimepicker2').datetimepicker({
//     locale: 'ru'
//   });
// });
// $(function () {
//   $('#datetimepicker3').datetimepicker({
//     format: 'LT'
//   });
// });
// $(function () {
//   $('#datetimepicker4').datetimepicker();
// });
// $(function () {
//   $('#datetimepicker5').datetimepicker({
//     defaultDate: "11/1/2013",
//     disabledDates: [
//     moment("12/25/2013"),
//     new Date(2013, 11 - 1, 21),
//     "11/22/2013 00:53"
//     ]
//   });
// });
// $(function () {
//   $('#datetimepicker6').datetimepicker();
//   $('#datetimepicker7').datetimepicker();
//   $("#datetimepicker6").on("dp.change", function (e) {
//     $('#datetimepicker7').data("DateTimePicker").minDate(e.date);
//   });
//   $("#datetimepicker7").on("dp.change", function (e) {
//     $('#datetimepicker6').data("DateTimePicker").maxDate(e.date);
//   });
// });

// // sele????o de tipo por dias
// $(function () {
//   $('#datetimepicker10').datetimepicker({
//     viewMode: 'days',
//     format: 'DD/MM/YYYY',
//     language: 'pt-BR'
//   });
// });
// // sele????o inline com data e hora
// $(function () {
//   $('#datetimepicker12').datetimepicker({
//     inline: false,
//     format: 'DD/MM/YYYY hh:mm',
//     sideBySide: true
//                 // language: 'pt-BR'
//               });
// });
// datepicker

//
//DependentFields
$(document).ready(function() {
  //DependentFields.bind()
});
//DependentFields


$(function() {
    $("#basic-chart-source").orgChart({container: $("chart")});
});

