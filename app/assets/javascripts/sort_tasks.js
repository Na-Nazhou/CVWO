$(document).on('turbolinks:load', function() {
  $(document).on('click', '#sort_tasks_by_ddl', function(event) {
    event.preventDefault();
    ongoing_tasks = $('tbody:first');
    completed_tasks = $('tbody:last');
    function _comp_fn(task1, task2) {
      return $(task1).find('td:nth-child(2)').text() <
        $(task2).find('td:nth-child(2)').text() ? -1 : 1;
    }
    ongoing_tasks.find('tr').sort(_comp_fn).appendTo(ongoing_tasks);
    completed_tasks.find('tr').sort(_comp_fn).appendTo(completed_tasks);
  });
});
