class Task
  attr_reader :id
  attr_accessor :title, :description, :done
  def initialize(attributes)
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    if result.nil?
      nil
    else
      build_task(result)
    end
  end

  def save
    if id.nil?
      DB.execute("INSERT INTO tasks (title, description, done) VALUES (?, ?, ?)", title, description, done ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", title, description, done ? 1 : 0, id)
    end
  end

  def self.all
    DB.execute("SELECT * FROM tasks").map { |task_hash| build_task(task_hash) }
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id=?", id)
  end

  private

  def self.build_task(row)
    Task.new(
      id: row["id"],
      title: row["title"],
      description: row["description"],
      done: row["done"] == 1
    )
  end
end
