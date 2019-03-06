defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(str) do
    letters =
      str
      |> String.downcase
      |> String.replace(~r{[^\w]}u, "")
      |> String.graphemes

    length(letters) == length(Enum.uniq letters)
  end
end
