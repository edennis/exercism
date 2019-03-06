defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    [x, y, z] = Enum.sort([a, b, c])
    cond do
      x <= 0            -> {:error, "all side lengths must be positive"}
      x + y <= z        -> {:error, "side lengths violate triangle inequality"}
      x == z            -> {:ok, :equilateral}
      x == y || y == z  -> {:ok, :isosceles}
      true              -> {:ok, :scalene}
    end
  end
end
