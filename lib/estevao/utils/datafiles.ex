defmodule Estevao.Utils.Datafiles do
  @otp_app Mix.Project.config()[:app]

  def read_data_file!(file) do
    Path.join([:code.priv_dir(@otp_app), "repo", "data", file])
    |> File.read!()
    |> String.split("\n")
  end
end
