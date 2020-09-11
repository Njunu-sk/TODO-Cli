require 'thor'
require 'pstore'

class TODOApp < Thor
  desc "add_task NAME", "add a new task to your TODO list"
  def add_task(name)
    PStore.new("/tmp/task.txt").transaction { |store| store[name] = true }
  end
  
  desc "delete_task name", "remove task from your TODO list"
  def delete_task(name)
    PStore.new("/tmp/task.txt").transaction { |store| store.delete(name) }
  end

  desc "list_task", "list all TODO tasks"
  def list_task
    PStore.new("/tmp/task.txt").transaction do |store|
        store.roots.each_with_index { |task, idx| puts "#{idx+1}.#{task}"}
    end
  end
end

TODOApp.start(ARGV)