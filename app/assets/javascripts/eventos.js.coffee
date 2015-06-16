$(document).ready ->
  $('#calendar').fullCalendar
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
