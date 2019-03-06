defmodule Binary do
  use Bitwise

  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    cond do
      string =~ ~r/^[01]+$/ ->
        convert(string)
      true ->
        convert("")
    end
  end

  defp convert(string) do
    reducer = fn 1, {acc, i} -> {acc + (1 <<< i), i + 1}
                 0, {acc, i} -> {acc, i + 1}
              end

    {number, _} = string
                  |> String.reverse
                  |> String.graphemes
                  |> Enum.map(&String.to_integer/1)
                  |> Enum.reduce({0, 0}, reducer)
    number
  end
end
