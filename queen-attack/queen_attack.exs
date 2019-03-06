defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @size 7

  @white_default {0, 3}
  @black_default {7, 3}

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  def new() do
    new(@white_default, @black_default)
  end
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white, black) when white != black do
    %__MODULE__{white: white, black: black}
  end
  def new(_, _), do: raise ArgumentError

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    for x <- 0..@size, y <- 0..@size do
      cond do
        {x, y} == queens.white -> "W"
        {x, y} == queens.black -> "B"
        true                   -> "_"
      end
    end
    |> Enum.chunk(8)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    can_attack?(queens.white, queens.black)
  end

  defp can_attack?({x, _}, {x, _}), do: true
  defp can_attack?({_, y}, {_, y}), do: true
  defp can_attack?({xw, yw}, {xb, yb}) when abs(xw - xb) == abs(yw - yb), do: true
  defp can_attack?(_, _), do: false
end
