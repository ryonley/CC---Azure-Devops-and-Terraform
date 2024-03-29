# Get Base Image (Full .NET SDK)
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS=http://*:80

COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "weatherapi.dll"]
