using Microsoft.VisualBasic;
using System.ComponentModel.DataAnnotations;

namespace BlazorToDoApp.Models
{
    public class TodoItem
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Task description is required.")]
        [StringLength(100, ErrorMessage = "Task description cannot exceed 100 characters.")]
        public string Task {  get; set; }
        public bool IsCompleted { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.Now;
        public int? CategoryId { get; set; }
        public Category Category { get; set; }
        public DateTime? DueDate { get; set; }
    }
}
