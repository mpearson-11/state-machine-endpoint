# base image elixer to start with
FROM elixir:1.6.2

# install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# install the latest phoenix 
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

# create app folder
RUN mkdir /app
COPY . /app
WORKDIR /app

# install dependencies
RUN mix deps.get

# run phoenix in *dev* mode on port 4000
CMD mix phx.digest
CMD mix phx.server