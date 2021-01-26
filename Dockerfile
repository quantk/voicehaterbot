FROM elixir:1.10.4
ARG tg_token 
COPY . .
RUN export MIX_ENV=prod && \
    export TG_TOKEN=${tg_token} && \
    rm -Rf _build && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix release && \
    mkdir -p /opt/app/bin && \
    cp -R _build/prod/rel/voicehaterbot /opt/app/bin
