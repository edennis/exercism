defmodule DNA do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> DNA.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "Lists must be the same length."}
  end
  def hamming_distance(strand1, strand2) do
    {:ok, number_of_mutations(strand1, strand2)}
  end

  defp number_of_mutations(strand1, strand2) do
    strand1
    |> Enum.zip(strand2)
    |> Enum.count(fn {l, r} -> l != r end)
  end
end
