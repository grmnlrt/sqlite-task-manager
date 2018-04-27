require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# READ one
# task = Task.find(2)
# p task

# CREATE
  # apero = Task.new(title: 'biere',description: 'au wagon')
  # apero.save
# UPDATE
  # task = Task.find(3)
  # task.title = "cider"
  # task.save

# READ all
  # p Task.all


# DELETE
task = Task.find(1)
task.destroy
