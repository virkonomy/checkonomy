defmodule CheckonomyTest.PublicApi do
  use ExUnit.Case
  doctest Checkonomy

  @host "https://exchange.tokenomy.com"

  defp get_available_market do
  	with {:ok, %HTTPoison.Response{body: body, status_code: 200}} <- HTTPoison.get(@host <> "/api/market_info"),
  		 {:ok, result} <- Jason.decode(body) do
  		 	return = result |> Enum.map(fn x -> "#{x["base"]}_#{x["quote"]}" |> String.downcase end)
  		 	{:ok, return}
  	else
  		_err -> {:error, "Cannot get all pair market from market_info endpoint"}
  	end
  end

  defp fetch_and_decode_json(url) do
  	assert {:ok, %HTTPoison.Response{body: body, status_code: 200}} = HTTPoison.get(url)

  	assert {:ok, _} = Jason.decode(body)  	
  end

  test "api summaries return 200 and the content structure is correct." do
  	assert {:ok, %HTTPoison.Response{body: body, status_code: 200}} = HTTPoison.get(@host <> "/api/summaries")

  	assert {:ok, %{"prices_24h" => _prices_24h, "tickers" => _tickers, "server_time" => _server_time}} = Jason.decode(body)
  end

  test "market_info return 200 and give all pairs." do
  	assert {:ok, pairs} = get_available_market()
  end

  test "test all ticker endpoint in available market from market_info endpoint." do
  	assert {:ok, pairs} = get_available_market()

  	Enum.each(pairs, fn x -> fetch_and_decode_json(@host <> "/api/#{x}/ticker") end)
  end  

  test "test all trades endpoint (trade history) in all available market from market_info endpoint." do
  	assert {:ok, pairs} = get_available_market()

  	Enum.each(pairs, fn x -> fetch_and_decode_json(@host <> "/api/#{x}/trades") end)
  end 

  test "test all depth endpoint (public order book) in all available market from market_info endpoint." do
  	assert {:ok, pairs} = get_available_market()

  	Enum.each(pairs, fn x -> fetch_and_decode_json(@host <> "/api/#{x}/trades") end)
  end   

end
