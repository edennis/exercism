defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(1) do
    """
No more bottles of beer on the wall, no more bottles of beer.
Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end
  def verse(2) do
    n = 1
    """
#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
Take it down and pass it around, no more bottles of beer on the wall.
    """
  end
  def verse(n) do
    n = n - 1
    """
#{bottles(n)} of beer on the wall, #{bottles(n)} of beer.
Take one down and pass it around, #{bottles(n - 1)} of beer on the wall.
    """
  end

  defp bottles(1), do: "1 bottle"
  defp bottles(n), do: "#{n} bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 100..1), do: range |> Enum.map_join("\n", &verse(&1))
end
