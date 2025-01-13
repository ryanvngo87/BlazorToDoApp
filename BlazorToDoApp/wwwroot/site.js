window.createTaskCategoriesChart = (categories, counts) => {
    const ctx = document.getElementById('taskCategoriesChart').getContext('2d');
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: categories,
            datasets: [{
                label: 'Task Categories',
                data: counts,
                backgroundColor: ['#007bff', '#28a745', '#ffc107', '#dc3545'],
            }]
        }
    });
};
