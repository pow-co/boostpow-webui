require Logger

defmodule Proofofwork.AMQP do
  @chann

  defp connect do
      Logger.debug("CONNECT AMQP")
    if @chan do
      @chan
    else
      Logger.debug("CONNECT AMQP")
      {:ok, conn} = AMQP.Connection.open(System.get_env("AMQP_URL"))
      {:ok, chan} = AMQP.Channel.open(conn)

      @conn = conn
      @chan = chan
    end
  end

  defp publish(topic, message) do
    chan = connect()
    AMQP.Basic.publish(chan, "pow.co", topic, message) 
  end

end
