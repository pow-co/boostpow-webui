# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url = System.get_env("DATABASE_URL")

config :proofofwork, Proofofwork.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base = 'eb295dffcec99d977b561444dc4e4b3c'
  #System.get_env("SECRET_KEY_BASE") ||
  #  raise """
  #  environment variable SECRET_KEY_BASE is missing.
  #  You can generate one by calling: mix phx.gen.secret
  #  """

config :proofofwork, ProofofworkWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4100"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :proofofwork, ProofofworkWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
