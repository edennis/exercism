defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Enum.map(0..(num - 1), &row(&1))
  end

  defp row(n) do
    Enum.map(0..n, &element(n, &1))
  end

  defp element(_, 0), do: 1
  defp element(n, k) when n == k, do: 1
  defp element(n, k) do
    element(n, k - 1) * (n + 1 - k) / k
  end
end
