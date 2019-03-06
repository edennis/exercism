defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.graphemes
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(&double_every_other/1)
    |> Enum.sum
  end

  defp double_every_other({number, i}) when rem(i, 2) == 1 do
    case number * 2 do
      n when n > 9 -> n - 9
      n            -> n
    end
  end
  defp double_every_other({n, _}), do: n

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    n = checksum(number)
    rem(n, 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    n = checksum(number <> "0")
    number <> "#{rem(n * 9, 10)}"
  end
end
