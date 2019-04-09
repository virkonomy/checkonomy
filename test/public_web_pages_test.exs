defmodule CheckonomyTest.PublicWebPages do
  use ExUnit.Case
  use Hound.Helpers
  doctest Checkonomy

  hound_session()

  test "visit tokenomy.com and check title" do
    navigate_to("https://www.tokenomy.com/")

    assert page_title() == "TOKENOMY"
  end

  test "visit tokenomy.com and navigate to exchange menu" do
    navigate_to("https://www.tokenomy.com/")

    # adjust window size
    [handle] = window_handles()
    set_window_size(handle, 1920, 1080)

    # find exchange link menu
    exchange_link = find_element(:xpath, "//*[@id=\"main-navbar\"]/ul/li[1]/a")
    IO.inspect(inner_html(exchange_link))
    click(exchange_link)

    assert page_title() == "Market - Tokenomy"
  end
end
