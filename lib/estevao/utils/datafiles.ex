defmodule Estevao.Utils.Datafiles do
  @moduledoc """
  Provides utility function to read data files from a private directory.

  This module contains functions that aid in reading data files from the
  private directory of the OTP application. This can be useful for loading
  configuration, seed data, etc. from local files.
  """
  @otp_app Mix.Project.config()[:app]

  @doc """
  Reads the contents of the specified file from the 'priv/repo/data' directory and splits it into lines.

  This function takes a filename, reads the contents of the file from the
  'priv/repo/data' directory of the OTP application, and splits the contents into lines.

  ## Params

    - `file`: A string representing the filename.

  ## Returns

  A list of strings, where each string is a line from the file.

  ## Raises

  `File.Error` if the file could not be read.

  ## Example

      iex> read_data_file!("test_data.txt")
      ["line1", "line2", "line3"]
  """
  def read_data_file!(file) do
    [:code.priv_dir(@otp_app), "repo", "data", file]
    |> Path.join()
    |> File.read!()
    |> String.split("\n")
  end
end
