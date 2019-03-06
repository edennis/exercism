defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    ~r/(\w)\1*/
    |> Regex.scan(string)
    |> Enum.map(&encode_pair/1)
    |> Enum.join
  end

  defp encode_pair([count, char]) do
    Integer.to_string(String.length(count)) <> char
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r/(\d+)(\w)/
    |> Regex.scan(string, capture: :all_but_first)
    |> Enum.map(&decode_pair/1)
    |> Enum.join
  end

  defp decode_pair([count, char]) do
    List.duplicate(char, String.to_integer(count))
  end
end
