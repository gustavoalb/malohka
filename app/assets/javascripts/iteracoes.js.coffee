# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  fieldsCount = undefined
  maxFieldsCount = 4
  $addLink = $('a.add_nested_fields')

  toggleAddLink = ->
    $addLink.toggle fieldsCount <= maxFieldsCount
    return

  $(document).on 'nested:fieldAdded', ->
    fieldsCount += 1
    toggleAddLink()
    return
  $(document).on 'nested:fieldRemoved', ->
    fieldsCount -= 1
    toggleAddLink()
    return
  # count existing nested fields after page was loaded
  fieldsCount = $('form .fields').length
  toggleAddLink()
  return
jQuery ->
$('.best_in_place').best_in_place()
$('.best_in_place').bind 'ajax:success', ->
  $(this).closest('tr').effect 'highlight'
  return
