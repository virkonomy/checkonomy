defmodule Checkonomy do
  @moduledoc """
  Documentation for Checkonomy.
  """

  use Hound.Helpers

  def fetch_ip do
    # starts Hound session. Required before we can do anything
    Hound.start_session()

    # visit the website which shows the visitor's IP
    navigate_to("https://exchange.tokenomy.com/api/summaries")

    # display its raw source
    isi = page_source()

    Jason.decode(isi) |> IO.inspect()

    # cleanup
    Hound.end_session()
  end
end
