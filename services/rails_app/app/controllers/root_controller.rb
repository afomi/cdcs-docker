class RootController < ApplicationController
  def index
    render json: {
      message: "Rails 8 service is running",
      postgres_url: ENV["DATABASE_URL"],
      redis_url: ENV["REDIS_URL"],
      mongo_url: ENV["MONGO_URL"]
    }
  end
end
