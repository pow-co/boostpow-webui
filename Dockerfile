FROM elixir:1.11

RUN mix local.hex --force \
  && mix local.rebar --force

WORKDIR /root/app

ADD ./ /root/app/

EXPOSE 4000

ENV MIX_ENV=prod
ENV PORT=4000

RUN mix deps.get
RUN mix deps.compile
RUN mix compile
RUN mix phx.digest

CMD ["mix", "phx.server"]
