require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# READ one
task = Task.find(1)
puts "#{task.done == 0 ? '[ ]' : '[X]'} #{task.title}: #{task.description}"

# CREATE
new_task = Task.new("title" => 'Buy some beers', "description" => 'Quickly!')
new_task.save
p new_task

# UPDATE
task = Task.find(2)
task.title = "Make cookies"
task.description = "With chocolate"
task.save

# READ all
tasks = Task.all
tasks.each do |task|
  puts "#{task.done == 0 ? '[ ]' : '[X]'} #{task.title}: #{task.description}"
end

# DELETE
task = Task.find(3)
task.destroy
