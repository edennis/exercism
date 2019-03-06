defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer

  def to_decimal(hex) do
    chars = to_chars(hex)
    to_decimal(chars, 0)
  end

  defp to_chars(str) do
    str |> String.downcase |> String.to_charlist
  end

  defp to_decimal([], acc), do: acc
  defp to_decimal([c | chars], acc) do
    case to_int(c) do
      {:ok, i} -> to_decimal(chars, (16 * acc) + i)
      :error   -> 0
    end
  end

  defp to_int(c) when c in ?0..?9, do: {:ok, c - ?0}
  defp to_int(c) when c in ?a..?f, do: {:ok, c - ?a + 10}
  defp to_int(_), do: :error
end
