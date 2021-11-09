ARG VERSION=6.0-alpine3.14
FROM mcr.microsoft.com/dotnet/core/sdk:$VERSION AS build-env
WORKDIR /app
ADD /src .
RUN dotnet publish \
  --runtime alpine-x64 \
  --self-contained true \
  /p:PublishTrimmed=true \
  /p:PublishSingleFile=true \
  -c Release \
  -o ./output
FROM mcr.microsoft.com/dotnet/core/runtime-deps:$VERSION
RUN adduser \
  --disabled-password \
  --home /app \
  --gecos '' app \
  && chown -R app /app
USER app
WORKDIR /app
COPY --from=build-env /app/output .
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1 \
  DOTNET_RUNNING_IN_CONTAINER=true \
  ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["./simpleapi", "--urls", "http://0.0.0.0:8080"]
