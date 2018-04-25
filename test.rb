require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# READ one

# CREATE

# UPDATE

# READ all

# DELETE
