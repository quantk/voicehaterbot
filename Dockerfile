FROM elixir:1.10.4
ARG tg_token 
WORKDIR /app
COPY . .
RUN export MIX_ENV=prod && \
    export TG_TOKEN=${tg_token} && \
    rm -Rf _build && \
    rm -rf deps && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix release

CMD ["_build/prod/rel/voicehaterbot/bin/voicehaterbot", "start"]