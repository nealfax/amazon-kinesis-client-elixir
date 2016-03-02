
config = [stream_name: "roa-dev",
  executable_name: "./sample/simple_kinesis_processor.sh",
  application_name: "ElixirKCLSample",
  max_records: 5,
  region_name: 'us-east-1',
  idle_time_between_reads_in_millis: 500]

Kcl.Executor.run config

