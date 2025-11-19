class Logger
  def initialize
    @file_content = ""
  end

  # temp dummy implementation
  def log_invoice(name, total)
    @file_content += "User: #{name}, Total: #{total}"
  end
end
