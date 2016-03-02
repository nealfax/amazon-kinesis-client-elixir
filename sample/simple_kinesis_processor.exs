defmodule SimpleKinesisClient do
  use Kcl.RecordProcessor
  require Logger

  def process_record data do
    # write the data to a file
    {:ok, file} = File.open "simplekinesisclient", [:write]
    IO.binwrite file, "I got #{data}"
    File.close file
    Logger.info "I got #{data}"
  end
end

Kcl.KCLProcess.run(SimpleKinesisClient)
