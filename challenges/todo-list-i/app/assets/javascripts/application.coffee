#= require jquery
#= require jquery_ujs
#= require_tree .

$ ->
  # Focus on description field for a new task on page load
  $('#task_description').focus()

  # Notifies server of done/undone task state on checkbox change
  tasksContainer = $('.tasks')
  tasksContainer.on 'change', '.task input[type="checkbox"]', ->
    taskId = $(this).data('task-id')
    checked = $(this).prop('checked')

    # add/remove a 'done' class on task state change
    method = if checked then 'addClass' else 'removeClass'
    $(this).parent()[method]('done')
      
    # send the notification to the server
    data = if checked then {} else { '_method': 'delete' }
    $.post("/tasks/#{taskId}/completion", data)
