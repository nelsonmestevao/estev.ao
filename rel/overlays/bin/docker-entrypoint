#!/bin/sh -e

# If running the server, run migrations first
if [ "$#" -eq 1 ] && [ "$1" = "/app/bin/server" ]; then
  echo "Running migrations before starting server..."
  /app/bin/migrate
  echo "Migrations completed!"
fi

# Execute the original command
exec "${@}"

