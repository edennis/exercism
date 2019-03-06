defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @names ~W{alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry}a

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @names) do
    student_names = Enum.sort(student_names)

    [first_row, second_row] =
      String.split(info_string, "\n")
      |> Enum.map(&String.graphemes(&1) |> Enum.chunk(2))

    plants =
      Enum.zip(first_row, second_row)
      |> Enum.map(&Tuple.to_list(&1) |> Enum.concat)

    data = Enum.zip(student_names, plants)

    Map.new(student_names, fn name -> {name, plant_names(data[name])} end)
  end

  defp plant_names(nil), do: {}
  defp plant_names(list) do
    list
    |> Enum.map(&plant(&1))
    |> List.to_tuple
  end

  defp plant("G"), do: :grass
  defp plant("C"), do: :clover
  defp plant("R"), do: :radishes
  defp plant("V"), do: :violets
end
