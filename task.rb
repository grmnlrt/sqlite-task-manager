class Task
  attr_accessor :id, :title, :description, :done
  def initialize(attributes = {})
    @id = attributes["id"]
    @title = attributes["title"]
    @description = attributes["description"]
    @done = attributes["done"] || 0
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id = #{id}").first
    if result.nil?
      nil
    else
      Task.new(result)
    end
  end

  def save
    if self.id.nil?
      DB.execute("INSERT INTO tasks (title, description, done) VALUES ('#{self.title}','#{self.description}',#{self.done})")
      self.id = DB.last_insert_row_id
    else
      DB.execute("UPDATE tasks SET title = '#{self.title}', description = '#{self.description}', done = #{self.done} WHERE id = #{self.id}")
    end
  end

  def self.all
    DB.execute("SELECT * FROM tasks").map { |task_hash| Task.new(task_hash) }
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id=#{self.id}")
  end
end
