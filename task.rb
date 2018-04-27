class Task
  attr_writer :title
  def initialize( attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.find(id)
    result = DB.execute("SELECT * FROM tasks WHERE id = ?", id)
    hash = result.first
    if hash.nil?
      return nil
    else
      hash_to_task(hash)
    end
  end

  def save
    # 1. ID exists ?
    # 2. If yes, update
    # 3. If not, create
    if @id.nil?
      DB.execute("INSERT INTO tasks(title, description, done)
      VALUES(?, ?, ?)", @title, @description, @done ? 1 : 0)
      @id = DB.last_insert_row_id
    else
      DB.execute("UPDATE tasks SET title = ?, description = ?, done = ? WHERE id = ?", @title, @description, @done ? 1 : 0, @id)
    end
  end

  def self.all
    results = DB.execute("SELECT * FROM tasks")
    results.map do |result|
      hash_to_task(result)
    end
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", @id)
  end

  private

  def self.hash_to_task(result)
    hash_final = {id: result["id"], title: result["title"], description: result["description"], done: result["done"] == 1}
    Task.new(hash_final)
  end

end
