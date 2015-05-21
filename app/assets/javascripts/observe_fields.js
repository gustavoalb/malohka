
jQuery.fn.observe_field = function(frequency, callback) {
  return this.each(function(){
    var element = $(this);
    var prev = element.val();

    var chk = function() {
      var val = element.val();
      if(prev != val){
        prev = val;
element.map(callback); // invokes the callback on the element
}
};
chk();
frequency = frequency * 1000; // translate to milliseconds
var ti = setInterval(chk, frequency);
// reset counter after user interaction
element.bind('keyup', function() {
  ti && clearInterval(ti);
  ti = setInterval(chk, frequency);
});
});

};

jQuery(function($) {$("#turma_nivel_id").change(function() {
    // make a POST call and replace the content
    var nivel = $('#turma_nivel_id').val();
    jQuery.post("/turmas/cursos/?nivel=" + nivel, function(data){
      $("#cursos").html(data);    
    });
  });
});
