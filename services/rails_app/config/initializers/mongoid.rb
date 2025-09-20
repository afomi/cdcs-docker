require "mongoid"

Mongoid.load!(Rails.root.join("config", "mongoid.yml"), Rails.env.to_s)
