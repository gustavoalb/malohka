$(document).ready ->
  $('#calendar').fullCalendar
    editable: true,
    droppable: true,
    dropAccept: '#lixeira',
    header:
      left: 'prev,next today',
      center: 'title',
      right: 'month,agendaWeek,agendaDay'
    defaultView: 'month',
    height: 500,
    slotMinutes: 15,

    events: '/eventos.json',

    timeFormat: {
        month: 'H:mm',
        ' ': 'H:mm-{H:mm}'
      },
    dragOpacity: "0.8"




    eventDrop: (evento, dayDelta, minuteDelta, allDay, revertFunc) ->
        updateEvent(evento);
    eventResize: (evento, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(evento);

    dayClick: (date, allDay, jsEvent, view) ->
      $('#evento_inicia_em').val(moment(date).format('DD/MM/YYYY HH:mm'));
      $('#evento_inicia_em').data("DateTimePicker").date(date.format('DD/MM/YYYY'))
      $('#evento_finaliza_em').val(moment(date).format('DD/MM/YYYY HH:mm'));
      $('#evento_finaliza_em').data("DateTimePicker").date(date.format('DD/MM/YYYY'))
      $('#fEvento').modal();
      $('#fEvento').css("z-index", "1500");


    eventClick:(event,jsEvent, view)->
      $('#titulo').html(event.title)
      $('#exibir_evento').html(event.exibir_evento)
      $('#pessoas').html(event.participantes)
      $('#excluir_evento').html(event.excluir_evento)
      $('#infoEvento').modal()
      $('#infoEvento').css("z-index", "1500");


updateEvent = (the_event) ->
  $.update "/eventos/" + the_event.id,
    event:
      title: the_event.title,
      starts_at: "" + the_event.start,
      ends_at: "" + the_event.end,
      description: the_event.description

