FROM mcr.microsoft.com/dotnet/sdk:8.0 AS installer-env

ARG ARG_BUILD_CONFIGURATION=Debug
ENV BUILD_CONFIGURATION=$ARG_BUILD_CONFIGURATION

RUN mkdir -p /home/site/wwwroot
WORKDIR /src/dotnet-function-app
COPY . ./
RUN dotnet publish "com/org/project/org.project.app.csproj" -c $BUILD_CONFIGURATION --output /home/site/wwwroot

FROM mcr.microsoft.com/azure-functions/dotnet-isolated:4-dotnet-isolated8.0
ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY --from=installer-env ["/home/site/wwwroot", "/home/site/wwwroot"]
