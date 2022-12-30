defmodule Mix.Tasks.Compile.MakeBindings do
  def run(_) do
    {_, exit_code} = System.cmd("make", ["-j4"], into: IO.stream(:stdio, :line))

    case exit_code do
      0 -> :ok
      _ -> :error
    end
  end
end

defmodule Libsecp256k1.Mixfile do
  use Mix.Project

  def project do
    [
      app: :libsecp256k1,
      version: "0.1.12",
      language: :erlang,
      description: "Erlang NIF bindings for the the libsecp256k1 library",
      package: [
        name: "libsecp256k1_nash_fork",
        files: [
          "LICENSE",
          "Makefile",
          "README.md",
          "c_src/libsecp256k1_nif.c",
          "etest/libsecp256k1_tests.erl",
          "mix.exs",
          "priv/.empty",
          "src/libsecp256k1.erl"
        ],
        maintainers: ["Dominic Letz"],
        licenses: ["MIT"],
        links: %{
          "GitHub" => "https://github.com/nash-io/libsecp256k1",
          "Forked from" => "https://github.com/diodechain/libsecp256k1"
        }
      ],
      compilers: [:make_bindings, :erlang, :app],
      deps: deps()
    ]
  end

  defp deps() do
    [
      {:mix_erlang_tasks, "0.1.0", runtime: false},
      {:ex_doc, "~> 0.17", only: :dev, runtime: false}
    ]
  end
end
